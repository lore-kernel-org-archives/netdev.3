Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D22BE02A;
	Wed,  1 Jul 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914245; cv=none; b=HImCWvDR/UI6E7WwyaAQhc28ena6h8DiIZIWUsCQceB6v+w0a8tw+XCoVYKR6joBL8j7K7+ACyw3NGEs24weTKy8EnP5XMn6bs+A4dUgVkCVJYsCPZa0poqntbX9m9tYEYuVs4+SpWA/DaoVx5+r55XgCEOx0dzWhorudAEwvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914245; c=relaxed/simple;
	bh=jyouimgOHe00t9Rj8kGA3cHbwAbO2s+J+L9yOVT9ZI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DjfuSbSTfbs6D1CF17xEZFkHmAh2nudsjmbnWnYNo2Luyn2xLVjrRb+xcte/5/pneI6gvenHHBZsIzhw9iDIGueyTfapv7+qQTJM0tn94XZgDedR6tI2aoFYaEZtW9szNnHwf45AYJ+Ww1PLEzvML0pzKSYPts7pccB7u31Hufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlVDab3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlVDab3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF371F00A3D;
	Wed,  1 Jul 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914244;
	bh=zag35WAocY+5o+OvST/25DSXMEyjKxN2j2GDhfTpF5s=;
	h=From:Subject:Date:To:Cc;
	b=TlVDab3taKef0cAHAYzvZWbe8q1YtiZZL2iPNyoLbK/g1DgwhDk/Gg9XGmwG9yKBF
	 PnWzy//tKPnrrbIuL4frm/k3LfXeFGF2iCiZ2yEZWg2OFMYpIXXwpiqEGDdeYqHh12
	 FxuPhn3YvDMqXdAYksh7EzEe29c/SLkcjH6s6U2CkKGL02I4pNZDh36BF+vzSNse+L
	 4L4BLyrOyvTeZB/fzHFqta9oFP7ZoXHXgsn7JsvszUlmHn9T2thGwzYpuKnFPY6iZ4
	 /hQnQLexd22jTT31Sc43CUIAg/Usjb6WzwhcixRdNrLp6OWItHPtroKWH161IHgwTI
	 elkTYlpzGTUfw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/4] drivers/net/ethernet: replace __get_free_pages() with
 kmalloc()
Date: Wed, 01 Jul 2026 16:57:17 +0300
Message-Id: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0cRWoC/yXMwQ6CMBAE0F8he3aTgkLQXzEeumW09VDNLhATw
 r/b6vFNZmYjgyYYXZqNFGuy9MoF7aGhEH1+gNNUTJ3rBjccHcuJJ00r1BhzhGbMLD3c2Mt59NJ
 SWb4V9/T5vV5vf9siT4S5XtWGeAOL+hxijSpp37/MWFb8jgAAAA==
X-Change-ID: 20260630-b4-drivers-ethernet-b5e085b98ab1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Mike Rapoport <rppt@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-net-drivers@amd.com, netdev@vger.kernel.org
X-Mailer: b4 0.16-dev

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/drivers-net-ethernet

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
v2 changes:
- split out ethernet drivers from a larger set 

v1: https://patch.msgid.link/20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org

---
Mike Rapoport (Microsoft) (4):
      bnx2x: use kzalloc() to allocate mac filtering list
      ice: use kzalloc() to allocate staging buffer for reading from GNSS
      sfc/siena: use kmalloc() to allocate logging buffer
      sfc: use kmalloc() to allocate logging buffer

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_gnss.c      | 5 +++--
 drivers/net/ethernet/sfc/mcdi.c                | 7 ++++---
 drivers/net/ethernet/sfc/siena/mcdi.c          | 7 ++++---
 4 files changed, 14 insertions(+), 11 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260630-b4-drivers-ethernet-b5e085b98ab1

Best regards,
--  
Sincerely yours,
Mike.

