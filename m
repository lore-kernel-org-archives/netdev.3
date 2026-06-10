Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48E36A340;
	Wed, 10 Jun 2026 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132662; cv=none; b=rDKw81Hnuc+nVJod7D1WPF8d2WBAhhDbpz2EAbzOVM6isHK7o6A/pbxatz3BxAqxYDnFG6PeTgWOSPWZaTRQU2XS4TRac+ISTBDie8bt4Wj5H+BKZWLUo/i+il0tmU8dABpnyZevWoS/nSy+6O+sBRITvufDMaVeIVQY9RIC/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132662; c=relaxed/simple;
	bh=e05wYXuo6Rnig5sVWE/a8UtaGwRE8fbO63Dp2L1ubI4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=YlolV+nMgeML9SxJ3I/+/id9z3Pm3vYztkPnghoVfxnjxXPF42xdTYUC6ndHjgfa6mbLiOlp/TfVVeHIHuTFljIhqJgZpIZAddXUaKTaK6f/k9H6LTVoQqztRO556BmAlEjoXoWmUrbNCWbILTRpleBQDkflJKNmkvOqCSP76mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifd/hahV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifd/hahV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781132659; x=1812668659;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=e05wYXuo6Rnig5sVWE/a8UtaGwRE8fbO63Dp2L1ubI4=;
  b=ifd/hahVtqXSNWVEyxUhLJMSEvcPP5LJTlXD7O10Ulh8iFCqG6+Z9k56
   Yv+XShjtUjyqzbSrtK83SRl3HG5xvzG2ug4CnOIBkGnHk5MrdJTKobCSt
   74+/PohiUlhclWKItLW/fn++zMR1EPIhmgfv6Mo47MqIglfHqJP4a85F0
   lHNszj1u8xyOSSZykZR3ckCilGOEL7ffOu7/TRRJc4YS3xF2VARcEGwFt
   +rRY586F3Rdlvz/7s63SNo+uKuVu0Gb6L8zvYa8/Yi0WnkV7URVJtsbcV
   4cMoNipEVFlfKd4KPSBH2N3jnNto/Qv0bqiiMLwm9BDmF+n0abYeabxOb
   g==;
X-CSE-ConnectionGUID: UcCc195VRGyxCgY4FY0InQ==
X-CSE-MsgGUID: /VLjG0u8SOistW8aI+8+aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81074116"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81074116"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 16:04:18 -0700
X-CSE-ConnectionGUID: IfwMSswuQKeXR78Inw71jg==
X-CSE-MsgGUID: 2UPwDDKpRauG9v11yWy1NA==
X-ExtLoop1: 1
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2026 16:04:17 -0700
Subject: [PATCH v2 4/5] binder: Remove mmap_lock fallback
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arve Hjønnevåg <arve@android.com>, Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 10 Jun 2026 16:04:17 -0700
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
Message-Id: <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Previously, the per-VMA locking could fail in the face of writers
which necessitate a fallback to mmap_lock. The new
vma_start_read_unlocked() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org

---

 b/drivers/android/binder_alloc.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff -puN drivers/android/binder_alloc.c~binder-vma-waiter drivers/android/binder_alloc.c
--- a/drivers/android/binder_alloc.c~binder-vma-waiter	2026-06-10 15:57:56.419452721 -0700
+++ b/drivers/android/binder_alloc.c	2026-06-10 15:57:56.423452863 -0700
@@ -259,21 +259,14 @@ static int binder_page_insert(struct bin
 	struct vm_area_struct *vma;
 	int ret = -ESRCH;
 
-	/* attempt per-vma lock first */
-	vma = lock_vma_under_rcu(mm, addr);
-	if (vma) {
-		if (binder_alloc_is_mapped(alloc))
-			ret = vm_insert_page(vma, addr, page);
-		vma_end_read(vma);
+	vma = vma_start_read_unlocked(mm, addr);
+	if (!vma)
 		return ret;
-	}
 
-	/* fall back to mmap_lock */
-	mmap_read_lock(mm);
-	vma = vma_lookup(mm, addr);
-	if (vma && binder_alloc_is_mapped(alloc))
+	if (binder_alloc_is_mapped(alloc))
 		ret = vm_insert_page(vma, addr, page);
-	mmap_read_unlock(mm);
+
+	vma_end_read(vma);
 
 	return ret;
 }
_
