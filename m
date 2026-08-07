Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173C233956
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069630; cv=none; b=XThYvEkE9MJR81gQyxGZL3bUVskmIaKw2ycQsY8sL1yrtlhAoMBXpbyMTQcYiJVPE4zL/HkIu/RYe/c/rkiz6ILH6OoGr2mDcBBlfzhXNlj0yScFebfSkJg5S3aVkK/fBlUQIgP2waUtSLLy7o1PHa7XGqEzJw+tq1jPc7nwYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069630; c=relaxed/simple;
	bh=0sIHYHXmj4kfkFzJUw5iipjWTE9r6gD6R63u5QZ378E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dd2kr1dIlRDet+MhLwWoTRFkx+wMJL4RaHnZ/bqHfz3z5gheu4V/fdkH7bwC+usYNpFBclQzMflyJeWvIbeS4EyXjufIbbz695tHcMSESUgRfUSDfzq5MNVsGh6nzdJhHFn9VUZE867ucbL9ucGzhRmCBWA2LexE2hwGoue6wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFxONSwv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFxONSwv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3106025a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786069629; x=1786674429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rt72B6lVkq2wOx7y/7/IbB63EiyH3V4VoZfX5qtaWOk=;
        b=EFxONSwv41DNxoIUBAuQH3qxgcFTC2ucmMRVeMwjw5MtegTuoXDUEr8NCDrND7lgb0
         CElXma4F2GYcUlApwXh5WGdiHXonlq1Pl3d4S9XmN4hvgNUokwgajYibn7lzN4lBLAKB
         tMDYz4rBE8JYflGovSosd1xzptUEr91ejHKCJP4NK0Ib4lop89yLC9zLxRmSa9n8UN9+
         9RPS3So+fwTNOEfWCyPpXAgXEoahbBrSoj3D+BmJwsBXRjod2mZDWyNz5rGic58NGunW
         mmnGgQ90jSgVc/P/F7vH571VlTyBcjciGpZ3s9aXm1H17Exs60R7aRohFRpdpHzlMF/m
         lkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069629; x=1786674429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rt72B6lVkq2wOx7y/7/IbB63EiyH3V4VoZfX5qtaWOk=;
        b=QldXh8+qynkXC2uygjPkjUxEcUilAeTJezL/MchZXzd9Ea3uoMJQs5D9G/4aCYBxhe
         4TKund7hD7Dxm9y/yR2kE6406YzD/+2NSFdnArmIs1hVtIzIQywmkspglNV3+rqnUpVC
         aFKslf6uH3YI1M7rgSzl/BXX3kbsjKrpv9mt1I+txDgV3ZJ7odE3fzD9KxSHbsZaO1W1
         sENgzs8bO5FA8Uy8gXcMK/mkv/OTIQ6kcLRGxlkKcTtaA4cCTeRcu+iOOZfl2Z0qsH/q
         5TH85BPNWH4TCcg451KxYjzcjLsr2Cb5NpVEWWhtSdLtyZ9Ugx3jPzh7bG6gu5aK4jrF
         EPIg==
X-Forwarded-Encrypted: i=1; AHgh+RoEPfwRQMupdP6MzTOj4FLZd1C9BL4pmAX4e3UbH0nwbf7MvdEky6JoXtpUWyh3DRXvN8xu250=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNghT5uW7hJUdOqHwYKP01fKiB0tapoyR7n0/M3NqHm1XnXX8Z
	eDHfrlJTdKDIHCIOE/mBpJjEZQtg7v7mFxQKvQHAC/XNF0JhnCxZXt8q
X-Gm-Gg: AR+sD11BUUQByY9+fKWFYsq8hvVWb0cPbMzHNbLy6Bxb82Lps6VYbqkmQS74sXhEEoX
	Zo8OZbkOd6PLb55EHpD/vcqqqXCr39eNeHCfjpxDzcc+Hm9MvNuRS2XpS6NiyafjQbmPEEIRUKc
	Af6dOC6C/9omWEcstjFPnvR8DCEsTUux/hdtNAwp4LtEnObdZKrnP5hwOQrOJRu9JJPecIXCetI
	Ktt3MM7+CQjaOeZcx5CbUSjrvBjo1/kGyYNa7xCWV2qalJKlp/zzX/M+IDfVIo64Ljg/C6r9Wlo
	i+cvXACY1kRHvUia4JxPc6FSTMu4glX1RWAZF29QWRrvM/7oiXOCCqBA1g6Lw+ADyfjNBzu5qgf
	gLjNlge7QvedZZkPkKpJVKnEefvHtaTHl6H8GDgUhudL365ZU5zDFeMtf6ygsypejasFO5VIJm7
	UPNBBljkoY9jeKRjSp9Oph9kbgZedqb+0LVhElBYzfgv0xkM1y8xNoJssiYX1N62EVfvp5VBYiA
	mivjcjHlIPSWRqrqBJx5qB8iTJhM9RL5hnGnmBCsmWKC6Rz9gMtSi0=
X-Received: by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3cb85ef91f7mr24553793637.20.1786069628776;
        Thu, 06 Aug 2026 19:27:08 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm1843082eec.18.2026.08.06.19.27.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 19:27:08 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] vduse: reject non-coherent iotlb entries in the coherent fault path
Date: Fri,  7 Aug 2026 12:26:57 +1000
Message-ID: <20260807022657.11318-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vduse_domain_get_coherent_page() turns an iotlb entry into a struct page
with pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT) and takes
a reference on it, with no check that map->addr is a physical address.

That assumption only holds for entries created by the domain's own
coherent allocator (vduse_domain_alloc_coherent(), which stores
virt_to_phys()). VDUSE registers its vdpa device with use_va=true, so for
a use_va device vhost_vdpa_va_map() passes a userspace virtual address as
the map address, and vduse_domain_set_map() copies those entries verbatim
into the same domain->iotlb. Both kinds of entry share one tree, and the
mmap fault handler only splits them by iova < bounce_size, so a use_va
entry placed above bounce_size lands in the coherent path.

A userspace daemon can exploit this: bind the device to virtio_vdpa so
the coherent allocator mints an entry whose backing file is the domain's
anon inode, obtain the domain fd with VDUSE_IOTLB_GET_FD2, rebind to
vhost_vdpa without deleting the vdpa device (vdpa_dev_del() only calls
_vdpa_unregister_device(), so the domain and the fd survive), install a
VHOST_IOTLB_UPDATE over the same iova with an arbitrary uaddr, then fault
the domain mapping. The kernel computes pfn = uaddr >> PAGE_SHIFT from
the userspace value and hands the daemon a struct page for a pfn of its
choosing -- an out-of-bounds vmemmap access for a wild value:

  BUG: unable to handle page fault for address: ffffea8000000008
  RIP: vduse_domain_mmap_fault+0x100/0x330

or, for a value that resolves to a valid pfn, a read/write window onto an
arbitrary physical page (confirmed: a write through the domain mapping
lands on a page selected purely by the fabricated pfn).

Coherent entries are always registered with domain->file as their backing
file, while entries installed through a vhost IOTLB message carry the
mapped vma's file (vhost_vdpa_va_map() stores get_file(vma->vm_file)).
Reject any entry whose file is not domain->file before calling
pfn_to_page(); the fault then returns VM_FAULT_SIGBUS. Legitimate coherent
mappings are unaffected.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 4dc76c0..847f010 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -221,6 +221,7 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	u64 start = iova & PAGE_MASK;
 	u64 last = start + PAGE_SIZE - 1;
 	struct vhost_iotlb_map *map;
+	struct vdpa_map_file *map_file;
 	struct page *page = NULL;
 
 	spin_lock(&domain->iotlb_lock);
@@ -228,6 +229,17 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	if (!map)
 		goto out;
 
+	/*
+	 * Only coherent allocations made by this domain are backed by a real
+	 * struct page here: their map->addr is a physical address and their
+	 * backing file is the domain's own anon inode. Entries installed via a
+	 * vhost IOTLB message on a use_va device instead carry a userspace
+	 * virtual address in map->addr, and must never be fed to pfn_to_page().
+	 */
+	map_file = (struct vdpa_map_file *)map->opaque;
+	if (map_file->file != domain->file)
+		goto out;
+
 	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
 	get_page(page);
 out:
-- 
2.43.0

