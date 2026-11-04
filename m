Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775664;
	b=OJz1CqcEirS1Np15E/wghSxUWg+cPOpnUNVkseOPF0rudlEp9p5o6EIdkset16Dp4r8K
	 UA6XU2i9+kjNIMq/aGUmlYroJ5GBhNPX/ID4ZDp8DMRWxUG0SbFGYRxzHEchPUATeJrIO
	 zSsgnIkUVdtrhnhlTslczu07EEJh8wekqWSXd1ob5R4qaa5+Px7cetE+V1xEeMZBS3OId
	 noz47EFLiGkoE1yDe7aWIdwDZcbPV3LPqMyKVosv3uJkGqTdrMK+7KP9ejpkAsfvof8mo
	 WhRQUKnEHWxcrvZUoSNf0vxMs6VrLTj9DpMIyC0p38zuEMpokm8zFWALyKAVgqGvtOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fvN+dcV9w8TnHuirEmYVFgOgx64649rstTkDzgki1m0=;
	b=fKNB3CdZHVpKb9Jgu18gGfxRmpTJWP7DO4ZOTO1hHjei+nk8fzaFfTc84aeMOs5+CR7c
	 elTGl0zjY4Labw5Er3r+HwwohhGoW6IBAZ8T0P8xRQ3v+nkXuueeA045isKP71ckyGVb7
	 +ZlWbYcEeA4fYjUARwCsH5AdTfQMwJ4cH0nVS84bwSZu8iVYbAjtVCw0CkMSV3u5ThdUZ
	 v8OjVc6z9j7WwZi6BPScZbDKsAZ5STfcTuSFivd/2Idk0lKZV3ybnULwN83d31yMNFY8m
	 STiDtH3GVr5D8kn7ISz+Aam2ZPHnRh4TK5V934vCZPXV7A/+R6KB9Ssvs5hW6bjnh5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Fw/djtjq";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C1606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9C1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Fw/djtjq
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a070781f63so191893b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793775663; x=1794380463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvN+dcV9w8TnHuirEmYVFgOgx64649rstTkDzgki1m0=;
        b=Fw/djtjqRmw1tpISTMyV28bXOmetSUSNu6T1F3N7pPdsg5Aa1gXwe30pN2ihU87Q2u
         emOIVInbyEc0UdABQ0ZQbb4omffhEeou2LzuXEaNcSnguEjXAdB8ZLn7R3AWP9EwJe+Q
         EzqpYFmvt6abMgX7MZW1b5KZhzkvY2o/zWMHmGhJr1+lNpPCp5MGvS/qs6NYWeDPRqu3
         SvIhEw55HOSuP7eCZgSEs5QILjiQwImr6qLESxARISF30fww1ZY1n0dGtcI87jX5oohl
         ipgBA28QHQHlz8ZNbV0y36W4UtrITE9St0fIyvaZzNLVrWr+1s/PxLCa2CQvF4hzpjQL
         vvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793775663; x=1794380463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvN+dcV9w8TnHuirEmYVFgOgx64649rstTkDzgki1m0=;
        b=H69KzXg76TUN6f91ZSAEsIVHQQgehGtZ/J7OzcbkPXWbZtuR37O5g6RkfFPkDwmGcH
         26Mb/eq8SHmiKvx2h1R+t04XR5JPOpdT7yRXm291Ozwu1ahG/2Y3kgKLaRybj7ZTwjPk
         9d51y+lqw+uYKiIk6kOPQyXmDReLAJBUnlUvMRasi0q9B0a0CifAcd9HqojtTnJDyw3L
         48r22lwtnjPvZM3WMw6kC/DVulE0IOIOeLTJEvg2614V4/Nn0FrTuZAFNjD2NZsSwrY5
         Wa2m3sz+vyCjzA+QWvOl7E2JTzDK3BuCb5HkcKzGnXSjr+oNMi2D219aOV2o0G8Xiuk9
         rEMw==
X-Forwarded-Encrypted: i=1; AKwUvBxriJyVZjBkaPFxOY/pGyRp5q3lNhxpUoHyPCepFJgnkOfrqtH8zSto4pBr6P9t88nhNp5qQEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+76zvSgTWIy0Z6Iom/GHO7fmDi9iYoYEekuHmeqG1aJL+nCGTq
	obSUzjwNjMy5WQ7SqtRd/dHShr4POL0LFzyomkv5sQd0F6jTVAIZlbXKfyUQ5wEBIus=
X-Gm-Gg: AYBFou2nF+OlVIjw8OtaTNm6rEngufzo3wSnv1PwB2F7R+JpiOy94wBbxa/7LHN2ly1
	7jVclxhWbc9iSf/RNOnwjd1EkBhwcFy7ABsfkrsD9Eo3knzBoWaH9zfHz3GUk0a0LDgx4kicAf6
	yLqLIsXD0rnUQ3EiQYGsr6hySWa8HWD6nn1nVCHc3vlSNt3i/OwlQgSwQZxpV0tXON2caWZNxyW
	mEsF3jBVJvlb35e+199Q+Q9/65WedRxpstmtr9nlWEU7I+2agIQIvavIn1oET5K4yBAtduHc7Ze
	kaiSUomJjGC3BYY/2vPUUhhvwk6sEmVWG/C5yzXXzaiDlz77W0udTXfQXxgSOeFNuWl1KcBAJTm
	xCt0ivpHwOXp++6F5z7thwrF7HO++kD22DJCDpa6V0VnTDqKOW0RUTsr4swJp7QA9yStGDqGEDP
	abDJK0MGgUJsHa7mQ1U8esOizmexMJaEa+/NpMclmyeqCQJDBlnMWM+DZZCxloEclYbSkO+SFFk
	e6s5nQLhAEjefWlAVLloeekcEoiYtXA3sV62jL4LL+MZ6SThyz179+fQIP4RnW63TNnCE3beX2X
	u7+7P8PHZcywYQtx3YWdcLlTqkts9N23DUaSXtrCHJ0iMr7Qd0j9tjLSrgS1Q+qasG9EtC3VO18
	nHW5uRd5V+yIJfcvJcjmABxxpRIUFrDiQdzFo
X-Received: by 2002:a05:6a21:1518:b0:3dd:85aa:4526 with SMTP id adf61e73a8af0-3e928db96fdmr13453369637.33.1793775662546;
        Tue, 03 Nov 2026 23:01:02 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7cc8ffsm495181b3a.14.2026.11.03.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:01:01 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH net] gve: bound the device reported RSS sizes in the RSS query
Date: Wed,  4 Nov 2026 16:00:41 +0900
Message-ID: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gve_adminq_process_rss_query() copies priv->rss_key_size bytes and
priv->rss_lut_size words out of the admin queue buffer.  Both sizes come
from the device: gve_parse_device_option() takes them from the RSS device
option with no validation, and gve_adminq_describe_device() stores them.
They are 16 bit fields, so either can be up to 65535.

The source is one GVE_ADMINQ_BUFFER_SIZE block and the payload starts
after the descriptor, so it holds at most 4088 bytes.  The only length
test compares the sum with descriptor->total_length, which the same device
wrote, and it is computed into a u16:

	u16 hash_lut_length;
	...
	hash_lut_length = priv->rss_lut_size * sizeof(*rxfh->indir);

	if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length !=
	    total_memory_length) {

A lut size of 16384 makes that product 65536, which truncates to zero, so
the device only has to report a total_length of 48 to pass.  The loop then
reads 16384 words, 65536 bytes, out of a 4096 byte block, and the walk
lands in rxfh->indir, which the ethtool core sized from the same device
value.  ETHTOOL_GRSSH and ETHTOOL_GRXFHINDIR hand that to the caller and
neither needs CAP_NET_ADMIN, net/ethtool/ioctl.c exempts them.

Reject sizes that do not fit the buffer, and compute the lut length in a
type that cannot truncate.

In the driver the block is dma_pool memory, so KASAN does not annotate it
and the contents of the neighbouring blocks leak with no report at all;
the report below comes from a KUnit harness that hands the handler a
kmalloc block of the same size, injects the device reply, and is not part
of this patch.  Unpatched, a lut of 16384 and a lut of 1022 both read past
the block; with the patch both are rejected with -EINVAL, and the sizes
the driver itself defaults to, 40 and 128, still work.

  BUG: KASAN: slab-out-of-bounds in gve_adminq_process_rss_query+0x3da/0x4a0
  Read of size 4 at addr ffff888002845000 by task kunit_try_catch/54

  CPU: 0 UID: 0 PID: 54 Comm: kunit_try_catch Tainted: G                 N  7.3.0-dirty #11 PREEMPT(lazy)
  Tainted: [N]=TEST
  Call Trace:
   <TASK>
   dump_stack_lvl+0x3f/0x50
   print_report+0xcd/0x620
   ? gve_adminq_process_rss_query+0x3da/0x4a0
   kasan_report+0xde/0x110
   ? gve_adminq_process_rss_query+0x3da/0x4a0
   gve_adminq_process_rss_query+0x3da/0x4a0
   gve_rss_run.constprop.0+0xa7/0x1a0
   ? __pfx_gve_rss_run.constprop.0+0x10/0x10
   ? __pfx_read_tsc+0x10/0x10
   ? ktime_get_ts64+0x192/0x250
   kunit_try_run_case+0x1ca/0x4b0
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? kthread_affine_node+0x247/0x360
   ? __pfx_kthread_affine_node+0x10/0x10
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36a/0x4f0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34d/0x620
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x22/0xde0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x19/0x30
   </TASK>

  Allocated by task 54:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_noprof+0x19b/0x3e0
   kunit_kmalloc_array+0x1b/0x50
   gve_rss_ctx_init+0x40a/0x910
   gve_rss_run.constprop.0+0x93/0x1a0
   kunit_try_run_case+0x1ca/0x4b0
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36a/0x4f0
   ret_from_fork+0x34d/0x620
   ret_from_fork_asm+0x19/0x30

  The buggy address belongs to the object at ffff888002844000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 0 bytes to the right of
   allocated 4096-byte region [ffff888002844000, ffff888002845000)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2840
  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
  flags: 0x4000000000000040(head|zone=1)
  page_type: f5(slab)
  raw: 4000000000000040 ffff888001042140 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
  head: 4000000000000040 ffff888001042140 dead000000000122 0000000000000000
  head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
  head: 4000000000000003 ffffea00000a1001 00000000ffffffff 00000000ffffffff
  head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888002844f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff888002844f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff888002845000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                     ^
   ffff888002845080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff888002845100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Fixes: fa46c456fa6e ("gve: Add RSS adminq commands and ethtool support")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8b215fca9c1b63..1ba658cb2942be 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1615,7 +1615,7 @@ static int gve_adminq_process_rss_query(struct gve_priv *priv,
 					struct ethtool_rxfh_param *rxfh)
 {
 	u32 total_memory_length;
-	u16 hash_lut_length;
+	u32 hash_lut_length;
 	void *rss_info_addr;
 	__be32 *lut;
 	u16 i;
@@ -1623,6 +1623,14 @@ static int gve_adminq_process_rss_query(struct gve_priv *priv,
 	total_memory_length = be32_to_cpu(descriptor->total_length);
 	hash_lut_length = priv->rss_lut_size * sizeof(*rxfh->indir);
 
+	if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length >
+	    GVE_ADMINQ_BUFFER_SIZE) {
+		dev_err(&priv->dev->dev,
+			"rss sizes from device do not fit the adminq buffer: key %u lut %u\n",
+			priv->rss_key_size, priv->rss_lut_size);
+		return -EINVAL;
+	}
+
 	if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length != total_memory_length) {
 		dev_err(&priv->dev->dev,
 			"rss query desc from device has invalid length parameter.\n");

base-commit: 787268686c64be60023743b527645a907e38ccca
-- 
2.43.0

