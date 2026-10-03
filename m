Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230C49D590
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062586; cv=none; b=dkxR9nD5k7agydTYvoI4ma3HiNqqPeJdvCJ1GlWtmYUz5Q9xlcPw1MP4kHuyNWvZQffu6jT00y/d5EeeZXCSV1Jzm3oGEh6LNkqtaUw+Ht/bUCmBU6fPJ2E7Uuk0UdmqH3He+l7dXGKkdc5dZMPtGXzYoZseuKrvymBywqAxPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062586; c=relaxed/simple;
	bh=HZezqFHG4CfZ5iR0/LZ0zdzG9lX8598jo6XwAPIqyoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVMejLBvg11YCZoQDDM7GqzTzNhQMLNHh9BJrojZa3CTOXM+SET3dZBoxcwsT46JPKCDCW99eHbVYKRLxTS327FfazpqP8H8H+onCYgtu0dUUUK8Vq8dcocE9bc2hWhcN3dAYM+71W62ULJCwrIzxyivoyn8fUf2JA26H1YIWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3jZPc1B; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3jZPc1B"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e47a584edso110017166b.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062580; x=1791667380; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GInLAF6QzIbkn/554tL70qj8kbEMjqAAjjITOwkojYs=;
        b=J3jZPc1BywSFkUSJrG4v5Sjt8GEDAk1728E6sKcI6SsNQ2w1QLAKGFJKkIzBZzzCyL
         0AqS+9CBq5+VuZjskdu6Jerw4TAuUtoHMJCtIWu/xALsSaIMm2YJpI8syu89FxyOmit6
         tu46AfvfxkVjKq/62wg6YCMP7OX/jRmGYOoShuSlNUFj0srrx+GoLY9SHwFhSqSZZy8V
         cBQ1CB9Vax6jB027E9yXPfapc4a3cc+J8uHSFKQEIlEbRML+HYMFDssdgMTeF0LqNruk
         GymjkS4NamwIJxvaP5Mhgkqyrwm9o1TbHaABI8MVSUGSd+rdBwXZ/+iAAwRPCp5Bjxy2
         hFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062580; x=1791667380;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GInLAF6QzIbkn/554tL70qj8kbEMjqAAjjITOwkojYs=;
        b=PGwHsa0KfMlRHZcRy9H3C7s2hzJUHZqKjJkV6FU1vP8CycbFThZNnStTMrP+Lwq2Mp
         YckAOhCb1IFOaUl5rR/DcvX9l2ujxBPAsuIjAqZ5nTG3WQhOocecsUm0bUWMyUDviAGU
         d3WRHKevB4jPyCtxvHGILi0mEdrawM/4hPDGbU5j5Vb5R+5aR438uM8DXuPofIdUoXtw
         /kj8N/Ekg66+kBAJqksndjcIJFeNiz94SRJny/W0d9q8vIFtBAxy4bnybX/ZpBdRisnT
         0mVmSH98/0PbjzmoM27ZZxODwHRkCzYoIkfvrgOvxcVglW3qKcViTQCLQhg2SBNcTd33
         L81g==
X-Forwarded-Encrypted: i=1; AKwUvBwjFKtK3f4Yb58svO1pSGf74zCr/AVtPiOJevU25JrUX/F5RbimGYjTH93w19AoFscOle2c11g=@vger.kernel.org
X-Gm-Message-State: AFuF++m9S0YAPgzMjGeS6IyXBSLq9yBzRKCH47DlKirp3Hh3HsEKEBbi
	BgSc4lPjqAt9d0telMQKh2BPMj/FLkm/cs/IajrrgzFYn7LqJJ1caDR+OiEOMyPn2ptFLxTLJDL
	SiSicRA==
X-Received: from ejyb21.prod.google.com ([2002:a17:906:8355:b0:c2e:2022:87e8])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c011:b0:c2e:4e08:19b4
 with SMTP id a640c23a62f3a-c2e6e9c9fd6mr253423166b.3.1791062579466; Sat, 03
 Oct 2026 14:22:59 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:29 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-11-lrizzo@google.com>
Subject: [RFC: DMA_PMD 10/22] driver core: Add per-device dma_pmd_* sysfs attributes
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add four boolean attributes to struct device exposed under
/sys/devices/*/*/dma_pmd_*:
  - dma_pmd_rxbuf:   enable DMA_PMD pools for RX buffers / page_pool
  - dma_pmd_tx_hdrs: enable DMA_PMD pools for TX header bounce buffers
  - dma_pmd_rings:   enable DMA_PMD arena for coherent rings
  - dma_pmd_debug:   log coherent DMA alloc timing and arena usage

These can be used by device drivers to selectively enable DMA_PMD for
their allocations.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/base/core.c    | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  5 +++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a19..f8c3c42d84b8d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2905,6 +2905,43 @@ static ssize_t removable_show(struct device *dev, const struct device_attribute
 }
 static const DEVICE_ATTR_RO(removable);
 
+/* Per-device configuration to selectively enable DMA_PMD */
+#define DMA_PMD_BOOL_ATTR(name)						\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%u\n", READ_ONCE(dev->name));		\
+}									\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	bool val;							\
+	int ret = kstrtobool(buf, &val);				\
+	if (ret < 0)							\
+		return ret;						\
+	WRITE_ONCE(dev->name, val);					\
+	return count;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+DMA_PMD_BOOL_ATTR(dma_pmd_rxbuf);
+DMA_PMD_BOOL_ATTR(dma_pmd_tx_hdrs);
+DMA_PMD_BOOL_ATTR(dma_pmd_rings);
+DMA_PMD_BOOL_ATTR(dma_pmd_debug);
+
+static struct attribute *dev_attr_dma_pmd[] = {
+	&dev_attr_dma_pmd_rxbuf.attr,
+	&dev_attr_dma_pmd_tx_hdrs.attr,
+	&dev_attr_dma_pmd_rings.attr,
+	&dev_attr_dma_pmd_debug.attr,
+	NULL,
+};
+
+static const struct attribute_group dev_attr_dma_pmd_group = {
+	.attrs = dev_attr_dma_pmd,
+};
+
 int device_add_groups(struct device *dev,
 		      const struct attribute_group *const *groups)
 {
@@ -3012,8 +3049,20 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_removable;
 	}
 
+	if (dev->dma_mask) {
+		error = device_add_group(dev, &dev_attr_dma_pmd_group);
+		if (error)
+			goto err_remove_dev_physical_location;
+	}
+
 	return 0;
 
+ err_remove_dev_physical_location:
+	if (dev->physical_location) {
+		device_remove_group(dev, &dev_attr_physical_location_group);
+		kfree(dev->physical_location);
+		dev->physical_location = NULL;
+	}
  err_remove_dev_removable:
 	device_remove_file(dev, &dev_attr_removable);
  err_remove_dev_waiting_for_supplier:
@@ -3037,6 +3086,8 @@ static void device_remove_attrs(struct device *dev)
 	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_group(dev, &dev_attr_dma_pmd_group);
+
 	if (dev->physical_location) {
 		device_remove_group(dev, &dev_attr_physical_location_group);
 		kfree(dev->physical_location);
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b4..52aa4a7e1cc45 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -794,6 +794,11 @@ struct device {
 
 	enum device_removable	removable;
 
+	bool			dma_pmd_rxbuf;
+	bool			dma_pmd_tx_hdrs;
+	bool			dma_pmd_rings;
+	bool			dma_pmd_debug;
+
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

