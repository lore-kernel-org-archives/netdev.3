Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B934395AE4
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427137; cv=none; b=i2juPOqHh4VbchmfmAywPBtQeiS/uiTfJ3IwDeh1+IerL3JrmFN0n5SsM9pkf9tpuYbKSmmuryHSkSBoTUKafRuNCWEyFx4hqjSvmi1DxnbNc7tdiGRWM+PhzYJazcJrIJv2pWz7A7b3Z9GFIRyJgU2so5Js6OB0NbfVzsnmYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427137; c=relaxed/simple;
	bh=eBLc/fajVaYVMlUC08ftC/Ol9ERPhhZYmLH8glWz35o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhZ2GMrvSExz4FRbYu4LZERcvYQB/ZwD4MrNN+PuGv6grwBaRF9aqBw8oUmU2hbLtG2WIZqBANmsgP9ueYyIOjaWFM9P/ABAmp6w3KqTTJ+grVIUSjMCiBFV6lL9Lg/yu2biRLtDRjq7oipWUCYsTfOxNEdRHTnD9YpEkgsS8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=QDibZ67J; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="QDibZ67J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kbpaI48z3aydezJpv995H968vdo9CjvFSpAfPLYr7GA=; t=1789427135; x=1790291135; 
	b=QDibZ67J0AtmcIv62rIZouh7aaOfUzL0bvJZW77Vj0JEzrzFVjHp7X3zepCS182M2fjNMAYZNGP
	N2hsGpgL0UbF86FM5hzT8EiYoZwPbOBIW9O7AA2z+eIcXcrzXDPcmTaBh3u1WeaefkA3DcYAe9Jcl
	sWV+acC9NYaTR7TEHezoRPojoTfYaplYRLGLkP2xkIsr8EqAiI96DybPmK4jVmDYSKgQRPTyRhqI/
	zQyaBQOD00qgKe2O96fsSMIKWwIFdKR5dkXrGremNlQBNYlMqLF5lSu4FzTOa6LudlkNUlEcp/Xrr
	1wsTkgOG49kEPLdMjf5jZh979I4C62ZKcukQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6Fjw-0007WN-VU; Mon, 14 Sep 2026 16:05:34 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	skhan@linuxfoundation.org,
	bagasdotme@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 05/15] net: homa: create homa_tx_pool.h and homa_tx_pool.c
Date: Mon, 14 Sep 2026 16:05:05 -0700
Message-ID: <20260914230517.1190-6-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914230517.1190-1-ouster@cs.stanford.edu>
References: <20260914230517.1190-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 03ab429ffafe1312a310b436bd5cad44

These files manage reusable pools of pages (one per NUMA node), which
are used to hold the data of outgoing Homa messages.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_tx_pool.c | 527 ++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_tx_pool.h | 139 +++++++++++
 2 files changed, 666 insertions(+)
 create mode 100644 net/homa/homa_tx_pool.c
 create mode 100644 net/homa/homa_tx_pool.h

diff --git a/net/homa/homa_tx_pool.c b/net/homa/homa_tx_pool.c
new file mode 100644
index 000000000000..c6420ffe2d19
--- /dev/null
+++ b/net/homa/homa_tx_pool.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file manages a reusable pools of pages (one per NUMA node), that
+ * are used to hold the data of outgoing Homa messages. Homa uses these
+ * custom pools rather than, say, page_pools because Homa can free pages
+ * from its pools more aggressively than in page_pool. And, this module
+ * also implements a one-page cache page per core to use for allocating
+ * smaller chunks of tx memory.
+ */
+
+#include "homa_impl.h"
+#include "homa_tx_pool.h"
+
+DEFINE_PER_CPU(struct homa_tx_pool_core, homa_tx_pool_core);
+
+static void frag_page_set(skb_frag_t *frag, struct page *page)
+{
+	frag->netmem = page_to_netmem(page);
+}
+
+/**
+ * homa_tx_pool_init() - Invoked when a struct homa is created; initializes
+ * information related to this module.
+ * @homa:        Shared information about the Homa transport; pool-related
+ *               fields are assumed to have been initialized to zero.
+ * Return:       0 for success, negative errno on error
+ */
+int homa_tx_pool_init(struct homa *homa)
+{
+	u64 min_kb;
+	int i;
+
+	homa->tx_page_pool_min_kb = 1000;
+	min_kb = 3 * HOMA_MAX_MESSAGE_LENGTH;
+	do_div(min_kb, 1000);
+	homa->tx_page_pool_min_kb = min_kb;
+
+	/* Initialize NUMA-specfific page pools. */
+	homa->max_numa = -1;
+	for (i = 0; i < nr_cpu_ids; i++) {
+		struct homa_tx_pool_core *tx_core;
+		int numa = cpu_to_node(i);
+
+		BUG_ON(numa >= MAX_NUMNODES);
+		if (numa > homa->max_numa)
+			homa->max_numa = numa;
+		if (!homa->tx_pools[numa]) {
+			struct homa_tx_pool *pool;
+
+			pool = kzalloc_obj(*pool, GFP_ATOMIC);
+			if (!pool)
+				goto error;
+			homa->tx_pools[numa] = pool;
+		}
+		tx_core = &per_cpu(homa_tx_pool_core, i);
+		tx_core->pool = homa->tx_pools[numa];
+	}
+	pr_notice("%s found max NUMA node %d\n", __func__, homa->max_numa);
+	return 0;
+
+error:
+	homa_tx_pool_cleanup(homa);
+	return -ENOMEM;
+}
+
+/**
+ * homa_tx_pool_cleanup() - Invoked when a struct homa is deleted; cleans
+ * up information related to this module.
+ * @homa:  Overall information about the Homa transport.
+ */
+void homa_tx_pool_cleanup(struct homa *homa)
+{
+	int i, j;
+
+	for (i = 0; i < nr_cpu_ids; i++) {
+		struct homa_tx_pool_core *tx_core;
+
+		tx_core = &per_cpu(homa_tx_pool_core, i);
+		if (!tx_core)
+			continue;
+		if (tx_core->page) {
+			put_page(tx_core->page);
+			tx_core->page = NULL;
+			tx_core->page_size = 0;
+			tx_core->allocated = 0;
+		}
+		tx_core->pool = NULL;
+	}
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		struct homa_tx_pool *pool = homa->tx_pools[i];
+
+		if (!pool)
+			continue;
+		for (j = pool->avail - 1; j >= 0; j--)
+			put_page(pool->pages[j]);
+		pool->avail = 0;
+		kfree(pool);
+		homa->tx_pools[i] = NULL;
+	}
+
+	kfree(homa->tx_pages_to_free);
+	homa->tx_pages_to_free = NULL;
+	homa->tx_pages_to_free_slots = 0;
+}
+
+/**
+ * homa_tx_pool_alloc() - Allocate a block of memory in one or more
+ * fragments.
+ * @homa:        Shared information about the Homa transport.
+ * @length:       Total number of bytes to allocate.
+ * @num_frags:   Number of fragments of storage initially available at **frags;
+ *               modified to hold the total number of fragments
+ *               allocated.
+ * @frags:       Pointer to pointer to space in which to store fragments;
+ *               if this initial space is insufficient to hold all of the
+ *               fragments needed, will be overwritten with a dynamically
+ *               allocated block.
+ * Return:       0 for success, negative errno on error.
+ */
+int homa_tx_pool_alloc(struct homa *homa, int length, int *num_frags,
+		       skb_frag_t **frags)
+{
+	struct homa_tx_pool_core *tx_core;
+	skb_frag_t *cur_frags = *frags;
+	int max_frags = *num_frags;
+	int bytes_left = length;
+	int frags_allocated = 0;
+	skb_frag_t *frag;
+	int err;
+
+	/* Asssure atomicity with respect to SoftIRQ invocations or
+	 * task preemption (so we can access per-core info without races).
+	 */
+	local_bh_disable();
+	tx_core = &per_cpu(homa_tx_pool_core, smp_processor_id());
+
+	while (bytes_left  > 0) {
+		/* Expand the frag array if needed. */
+		if (frags_allocated == max_frags) {
+			skb_frag_t *new_frags;
+			int num_new;
+
+			num_new = ((bytes_left + HOMA_TX_PAGE_SIZE - 1) >>
+				   (PAGE_SHIFT + HOMA_TX_PAGE_ORDER)) +
+				  frags_allocated;
+			new_frags = kvmalloc_array(num_new, sizeof(*new_frags),
+						   GFP_ATOMIC);
+			if (!new_frags) {
+				err = -ENOMEM;
+				goto error;
+			}
+			memcpy(new_frags, cur_frags,
+			       frags_allocated * sizeof(*new_frags));
+			if (cur_frags != *frags)
+				kfree(cur_frags);
+			cur_frags = new_frags;
+			max_frags = num_new;
+		}
+
+		frag = &cur_frags[frags_allocated];
+		err = __homa_tx_pool_alloc_frag(tx_core, bytes_left, frag);
+		if (err != 0)
+			goto error;
+		frags_allocated++;
+		bytes_left -= skb_frag_size(frag);
+	}
+	local_bh_enable();
+	*frags  = cur_frags;
+	*num_frags = frags_allocated;
+	return 0;
+
+error:
+	homa_tx_pool_free(homa, frags_allocated, cur_frags);
+	if (cur_frags != *frags)
+		kfree(cur_frags);
+	*num_frags = 0;
+	local_bh_enable();
+	return err;
+}
+
+/**
+ * __homa_tx_pool_alloc_frag() - Allocate space for a single fragment.
+ * Caller must have disabled interrupts.
+ * @tx_core:   Core-specific information to use for the allocation.
+ * @length:    Desired length: actual length of fragment may be less
+ *             than this.
+ * @frag:      Store information about the allocated fragment here. Its
+ *             length may be less than @length. A reference will be taken
+ *             on its page.
+ * Return:     0 for success, otherwise a negative errno.
+ */
+int __homa_tx_pool_alloc_frag(struct homa_tx_pool_core *tx_core, int length,
+			      skb_frag_t *frag)
+{
+	struct page *page;
+	int page_size;
+
+	/* See if the allocation can be handled with the core's cached page. */
+	if (tx_core->page_size - tx_core->allocated >= length) {
+		get_page(tx_core->page);
+		frag_page_set(frag, tx_core->page);
+		frag->offset = tx_core->allocated;
+		skb_frag_size_set(frag, length);
+		tx_core->allocated += length;
+		if (tx_core->allocated == tx_core->page_size) {
+			put_page(tx_core->page);
+			tx_core->page = NULL;
+			tx_core->page_size = 0;
+			tx_core->allocated = 0;
+		}
+		return 0;
+	}
+
+	/* Must allocate a new page. */
+	page = homa_tx_pool_alloc_page(tx_core, &page_size);
+	if (!page)
+		return -ENOMEM;
+	frag_page_set(frag, page);
+	frag->offset = 0;
+	skb_frag_size_set(frag, min(page_size, length));
+
+	/* Retain the leftover part of the page as the core's cached page,
+	 * if it has more space available than the current cached page.
+	 */
+	if (!tx_core->page || (tx_core->page_size - tx_core->allocated) <
+			       (page_size - skb_frag_size(frag))) {
+		if (tx_core->page)
+			put_page(tx_core->page);
+		get_page(page);
+		tx_core->page = page;
+		tx_core->page_size = page_size;
+		tx_core->allocated = skb_frag_size(frag);
+	}
+	return 0;
+}
+
+/**
+ * homa_tx_pool_alloc_frag() - Allocate space for a single fragment.
+ * @homa:      Overall information about the Homa transport.
+ * @length:    Desired length: actual length of fragment may be less
+ *             than this.
+ * @frag:      Store information about the allocated fragment here. Its
+ *             length may be less than @length. A reference will be taken
+ *             on its page.
+ * Return:     0 for success, otherwise a negative errno.
+ */
+int homa_tx_pool_alloc_frag(struct homa *homa, int length, skb_frag_t *frag)
+{
+	struct homa_tx_pool_core *tx_core;
+	int result;
+
+	tx_core = &per_cpu(homa_tx_pool_core, smp_processor_id());
+	local_bh_disable();
+	result = __homa_tx_pool_alloc_frag(tx_core, length, frag);
+	local_bh_enable();
+	return result;
+}
+
+/**
+ * homa_tx_pool_alloc_page() - Allocate a new page for skb allocation for a
+ * given core. Any existing page is released.
+ * @tx_core:    Core-specific info; the page will be allocated in this core.
+ * @length:     The length of the allocated page (if any) will be stored here.
+ * Return:      The allocated page (with reference count 1) or NULL if
+ *              no page could be allocated.
+ */
+struct page *homa_tx_pool_alloc_page(struct homa_tx_pool_core *tx_core,
+				     int *length)
+{
+	struct homa_tx_pool *pool;
+	struct page *page;
+
+	/* Step 1: can we reuse the core's cached page? */
+	page = tx_core->page;
+	if (page && page_ref_count(page) == 1) {
+		*length = tx_core->page_size;
+		tx_core->page = NULL;
+		tx_core->page_size = 0;
+		tx_core->allocated = 0;
+		return page;
+	}
+
+	/* Step 2: can we retrieve a page from the pool for this NUMA node? */
+	pool = tx_core->pool;
+	if (pool->avail) {
+		spin_lock_bh(&pool->mutex);
+
+		/* Must recheck: could have changed before locked. */
+		if (pool->avail) {
+			pool->avail--;
+			if (pool->avail < pool->low_mark)
+				pool->low_mark = pool->avail;
+			page = pool->pages[pool->avail];
+			spin_unlock_bh(&pool->mutex);
+			*length = HOMA_TX_PAGE_SIZE;
+			return page;
+		}
+		spin_unlock_bh(&pool->mutex);
+	}
+
+	/* Step 3: can we allocate a big page? */
+	page = alloc_pages(GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN |
+			   __GFP_NORETRY, HOMA_TX_PAGE_ORDER);
+	if (likely(page)) {
+		*length = HOMA_TX_PAGE_SIZE;
+		return page;
+	}
+
+	/* Step 4: can we allocate a normal page? */
+	page = alloc_page(GFP_ATOMIC);
+	if (likely(page)) {
+		*length = PAGE_SIZE;
+		return page;
+	}
+	return NULL;
+}
+
+/**
+ * homa_tx_pool_free() - Release one or more fragments previously allocated
+ * by homa_tx_pool_alloc.
+ * @homa:        Shared information about the Homa transport.
+ * @num_frags:   Number of fragments at *frags.
+ * @frags:       Pointer to array of fragments to free; must not be used
+ *               after this function returns.
+ */
+void homa_tx_pool_free(struct homa *homa, int num_frags, skb_frag_t *frags)
+{
+	struct homa_tx_pool *pool;
+	int i;
+
+	if (num_frags <= 0)
+		return;
+
+	pool = homa->tx_pools[page_to_nid(skb_frag_page(&frags[0]))];
+	spin_lock_bh(&pool->mutex);
+	for (i = 0; i < num_frags; i++) {
+		struct page *page = skb_frag_page(&frags[i]);
+
+		if (compound_order(page) == HOMA_TX_PAGE_ORDER &&
+		    page_ref_count(page) == 1 &&
+		    pool->avail < HOMA_TX_POOL_LIMIT) {
+			pool->pages[pool->avail] = page;
+			pool->avail++;
+		} else {
+			put_page(page);
+		}
+	}
+	spin_unlock_bh(&pool->mutex);
+}
+
+/**
+ * homa_tx_pool_gc() - This function is invoked occasionally; its
+ * job is to gradually release pages from the page pools back to
+ * Linux, based on sysctl parameters such as tx_page_frees_per_sec.
+ * @homa:  Overall information about the Homa transport.
+ */
+void homa_tx_pool_gc(struct homa *homa)
+{
+	int i, max_low_mark, min_pages, release, release_max;
+	struct homa_tx_pool *max_pool;
+	u64 now = homa_clock();
+
+	if (now < homa->tx_page_free_time)
+		return;
+
+	/* Free pages every 0.5 second. */
+	homa->tx_page_free_time = now + (500 * homa_clock_khz());
+
+	/* Make sure we have space in which to collect pages to free. */
+	release_max = homa->tx_page_frees_per_sec / 2;
+	if (homa->tx_pages_to_free_slots < release_max) {
+		struct page **old = homa->tx_pages_to_free;
+
+		homa->tx_pages_to_free = kmalloc_array(release_max,
+						       sizeof(struct page *),
+						       GFP_ATOMIC);
+		if (homa->tx_pages_to_free) {
+			kfree(old);
+			homa->tx_pages_to_free_slots = release_max;
+		} else {
+			/* Couldn't allocate space; reuse existing space
+			 * and reduce how many pages we'll free.
+			 */
+			homa->tx_pages_to_free = old;
+			release_max = homa->tx_pages_to_free_slots;
+		}
+	}
+
+	/* Find the pool with the largest number of pages that haven't
+	 * been used recently.
+	 */
+	max_low_mark = -1;
+	for (i = 0; i <= homa->max_numa; i++) {
+		struct homa_tx_pool *pool = homa->tx_pools[i];
+
+		if (!pool)
+			continue;
+		spin_lock_bh(&pool->mutex);
+		if (pool->low_mark > max_low_mark) {
+			max_low_mark = pool->low_mark;
+			max_pool = pool;
+		}
+		pool->low_mark = pool->avail;
+		spin_unlock_bh(&pool->mutex);
+	}
+
+	/* Collect pages to free (but don't free them until after
+	 * releasing the lock, since freeing is expensive).
+	 */
+	spin_lock_bh(&max_pool->mutex);
+	min_pages = ((homa->tx_page_pool_min_kb * 1000)
+			+ (HOMA_TX_PAGE_SIZE - 1)) >> HOMA_TX_PAGE_SHIFT;
+
+	/* Note: may need to adjust max_low_mark to reflect changes made
+	 * while lock wasn't held.
+	 */
+	if (max_low_mark > max_pool->low_mark)
+		max_low_mark = max_pool->low_mark;
+	release = max_low_mark - min_pages;
+	if (release > release_max)
+		release = release_max;
+	for (i = 0; i < release; i++) {
+		max_pool->avail--;
+		homa->tx_pages_to_free[i] = max_pool->pages[max_pool->avail];
+	}
+	max_pool->low_mark = max_pool->avail;
+	spin_unlock_bh(&max_pool->mutex);
+
+	/* Free the pages that were collected. */
+	for (i = 0; i < release; i++) {
+		struct page *page = homa->tx_pages_to_free[i];
+
+		put_page(page);
+	}
+}
+
+/**
+ * homa_copy_to_frags() - Copy a block of data into an array of fragments.
+ * @filler:    Describes the current position in the array of fragments;
+ *             will be updated to reflect the copied data.
+ * @src:       Copy bytes from here into the fragments.
+ * @num_bytes: Number of bytes to copy.
+ * Return:     0 for success; -EINVAL if there isn't enough room in the
+ *             fragments for the new bytes.
+ */
+int homa_copy_to_frags(struct homa_frag_filler *filler, void *src,
+		       int num_bytes)
+{
+	int p_off, copied, p_len;
+	int bytes_this_frag;
+	struct page *p;
+	u8 *src_cur;
+
+	src_cur = src;
+	while (num_bytes > 0) {
+		if (filler->offset >= skb_frag_size(filler->frag)) {
+			filler->frag++;
+			filler->num_frags--;
+			if (filler->num_frags <= 0)
+				return -EINVAL;
+			filler->offset = 0;
+		}
+		bytes_this_frag = min(num_bytes,
+				      skb_frag_size(filler->frag) -
+				      filler->offset);
+		skb_frag_foreach_page(filler->frag,
+				      skb_frag_off(filler->frag) +
+				      filler->offset, bytes_this_frag, p,
+				      p_off, p_len, copied) {
+			u8 *vaddr = kmap_local_page(p);
+
+			memcpy(vaddr + p_off, src_cur, p_len);
+			kunmap_local(vaddr);
+			src_cur += p_len;
+		}
+		filler->offset += bytes_this_frag;
+		num_bytes -= bytes_this_frag;
+	}
+	return 0;
+}
+
+/**
+ * homa_copy_iter_to_frags() - Copy data from an iterator (presumably
+ * referring to user-space data) into an array of fragments.
+ * @filler:    Describes the current position in the array of fragments;
+ *             will be updated to reflect the copied data.
+ * @iter:      Copy bytes from here into the fragments.
+ * @num_bytes: Number of bytesto copy.
+ * Return:     0 for success; -EINVAL if there isn't enough room in the
+ *             fragments for the new bytes.
+ */
+int homa_copy_iter_to_frags(struct homa_frag_filler *filler,
+			    struct iov_iter *iter, int num_bytes)
+{
+	int p_off, copied, p_len;
+	int bytes_this_frag;
+	struct page *p;
+
+	while (num_bytes > 0) {
+		if (filler->offset >= skb_frag_size(filler->frag)) {
+			filler->frag++;
+			filler->num_frags--;
+			if (filler->num_frags <= 0)
+				return -EINVAL;
+			filler->offset = 0;
+		}
+		bytes_this_frag = min(num_bytes,
+				      skb_frag_size(filler->frag) -
+				      filler->offset);
+		skb_frag_foreach_page(filler->frag,
+				      skb_frag_off(filler->frag) +
+				      filler->offset, bytes_this_frag, p,
+				      p_off, p_len, copied) {
+			int result;
+			void *vaddr = kmap_local_page(p);
+
+			result = copy_from_iter(vaddr + p_off, p_len, iter);
+			kunmap_local(vaddr);
+			if (result != p_len)
+				return -EFAULT;
+		}
+		filler->offset += bytes_this_frag;
+		num_bytes -= bytes_this_frag;
+	}
+	return 0;
+}
diff --git a/net/homa/homa_tx_pool.h b/net/homa/homa_tx_pool.h
new file mode 100644
index 000000000000..aca47f9a3184
--- /dev/null
+++ b/net/homa/homa_tx_pool.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
+
+/* This module manages a pool of memory pages used for outgoing sk_buffs. */
+
+#ifndef _HOMA_TX_POOL_H
+#define _HOMA_TX_POOL_H
+
+#include <linux/percpu-defs.h>
+
+/**
+ * define HOMA_TX_PAGE_ORDER - exponent (power of two) determining how
+ * many pages to allocate in a high-order page for skb pages (e.g.,
+ * 2 means allocate in units of 4 pages).
+ */
+#define HOMA_TX_PAGE_ORDER 4
+
+/**
+ * define HOMA_TX_PAGE_SIZE - number of bytes corresponding to HOMA_PAGE_ORDER.
+ */
+#define HOMA_TX_PAGE_SIZE (PAGE_SIZE << HOMA_TX_PAGE_ORDER)
+
+/**
+ * define HOMA_TX_PAGE_SHIFT: HOMA_PAGE_SIZE == 1 << HOMA_TX_PAGE_SHIFT
+ */
+#define HOMA_TX_PAGE_SHIFT (PAGE_SHIFT + HOMA_TX_PAGE_ORDER)
+
+/**
+ * struct homa_tx_pool - A cache of free pages available for use.
+ * Each page is of size HOMA_TX_PAGE_SIZE, and a given pool is dedicated for
+ * use by a single NUMA node.
+ */
+struct homa_tx_pool {
+	/** @mutex: Used to synchronize access to the fields in this struct. */
+	spinlock_t mutex;
+
+	/** @avail: Number of free pages currently in the pool. */
+	int avail;
+
+	/**
+	 * @low_mark: Low water mark: smallest value of avail since the
+	 * last time homa_tx_pool_gc reset it.
+	 */
+	int low_mark;
+
+#define HOMA_TX_POOL_LIMIT 1000
+
+	/**
+	 * @pages: Pointers to pages that are currently free; the ref count
+	 * is 1 in each of these pages.
+	 */
+	struct page *pages[HOMA_TX_POOL_LIMIT];
+};
+
+/**
+ * struct homa_tx_pool_core - Stores core-specific information related to
+ * tx memory allocation. All values are assumed to be zero initially.
+ */
+struct homa_tx_pool_core {
+	/**
+	 * @pool: NUMA-specific page pool from which to allocate skb pages
+	 * for this core.
+	 */
+	struct homa_tx_pool *pool;
+
+	/**
+	 * @page: a page of data that is "owned" by this core and used for
+	 * allocation on this core (or NULL). This pointer is included in
+	 * the page's reference count.
+	 */
+	struct page *page;
+
+	/**
+	 * @page_size: total number of bytes in @page (including any
+	 * already allocated).
+	 */
+	int page_size;
+
+	/**
+	 * @allocated: number of (initial) bytes in @page that have already
+	 * been allocated for use.
+	 */
+	int allocated;
+};
+DECLARE_PER_CPU(struct homa_tx_pool_core, homa_tx_pool_core);
+
+/**
+ * struct homa_frag_filler - Used to iterate over an array of skb_frag_t's
+ * to copy data into them.
+ */
+struct homa_frag_filler {
+	/** @frag: Fragment currently being filled (in an array of frags). */
+	skb_frag_t *frag;
+
+	/**
+	 * @offset: Offset within @frag where the next byte of data should be
+	 * stored.
+	 */
+	int offset;
+
+	/**
+	 * @num_frags: Number of fragments in the array including @frag:
+	 * if this reaches zero then we have run out of space.
+	 */
+	int num_frags;
+};
+
+/**
+ * homa_frag_filler_init() - Initialize a frag filler.
+ * @filler:     Struct to initialize.
+ * @num_frags:  Number of fragments available to fill.
+ * @frags:      First in array of @num_frags fragments.
+ */
+static inline void homa_frag_filler_init(struct homa_frag_filler *filler,
+					 int num_frags, skb_frag_t *frags)
+{
+	filler->frag = frags;
+	filler->offset = 0;
+	filler->num_frags = num_frags;
+}
+
+int          homa_copy_iter_to_frags(struct homa_frag_filler *filler,
+				     struct iov_iter *iter, int num_bytes);
+int          homa_copy_to_frags(struct homa_frag_filler *filler, void *src,
+				int num_bytes);
+int          homa_tx_pool_alloc(struct homa *homa, int length, int *num_frags,
+				skb_frag_t **frags);
+int          __homa_tx_pool_alloc_frag(struct homa_tx_pool_core *tx_core,
+				       int length, skb_frag_t *frag);
+int          homa_tx_pool_alloc_frag(struct homa *homa, int length,
+				     skb_frag_t *frag);
+struct page *homa_tx_pool_alloc_page(struct homa_tx_pool_core *tx_core,
+				     int *length);
+void         homa_tx_pool_cleanup(struct homa *homa);
+void         homa_tx_pool_free(struct homa *homa, int num_frags,
+			       skb_frag_t *frags);
+void         homa_tx_pool_gc(struct homa *homa);
+int          homa_tx_pool_init(struct homa *homa);
+
+#endif /* _HOMA_TX_POOL_H */
-- 
2.43.0

