Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598128;
	b=RfIOs4neQn7/9Wi55wclGTzcpM6ukW9vPE1mihIJQUoH40lnp62epQgQPl7zFt/DvUtV
	 Fx/I+277sXiM8DfwaYcSt2nFftaahcaWS0LZdhHL0MmNWr0JtNX9uA0pas58iKosHTeHs
	 BcF3exT0rmrVBf9DDCva3A4alCQPsPfgDg5u8g8jdikaVY3O3zaolIK5gQUXoxH4nP3cO
	 3d6I0q48wvcLh5iXLyJd6bimt6fXo64+XVotCrsG020oh8elNUxoYYzWhnq0M8o1ocVDL
	 7DRLCWvBR7yxgVm4QBi98UiOVtjvj3mylCmhmJY07ZgdtYFgkmXbot7hOY0jU0xfFRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XlXnG5YdFZDLjnLxfZKMhexu3MIGr03hairmlo3RpRo=;
	b=TzN1s3uzAOeL4kMI9vkIlLWGMXm1Pfa5N0xYqKe9Ukl1Z3H66pekxEnL7NMggMH6KG1m
	 QkrIuToTujub8m8CPZd6NlrkcI+KzIGJBjEqCDFn6bFJCH/rgOcceHyp5I33lL6H+4CHq
	 y8S8lHDzdfl/CqlaDXjEwInGu634LlZo51ZZImvrqhmUWgccPjs3bOCzCwUxvF0zob5aj
	 cRvvFzZNZAsUHNBhO9OdU4D6c7C1F2MWvWGjeTqMnk6fi56/HdBD2wzyoAhwthBAVHBFO
	 Z5ynO5DaoJrUgR4zRpax9maCYX5ggQyPURW8wrLhL+D/5dNu9QIY8YiIU9YoI1L6MGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S5LY7KOU;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA8606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85DA8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S5LY7KOU
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so506966b3a.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598128; x=1793202928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XlXnG5YdFZDLjnLxfZKMhexu3MIGr03hairmlo3RpRo=;
        b=S5LY7KOUChhCVSr1rCRN/9bW/tE+c9V/UFw5uESi1Qwf4TWLNIn7DT6AKaoC1TB40L
         +xbHHT5KCG/RSPIeKYLo9WuHkfbfrdmCVNc4FyNdflFVdqwBZW8uCRlZrBLkuCJQ1wry
         hAdSTDFkbCV8U968uKLhPwFixtB7T7xS5LAjqvNJPz7GWmx3aoPF8lynMJeMqw+HLuIG
         B7FAkbk1btsCSaG6+DO+EH1mRzbXodwFf0Ot4340p5ijHRzau+0uO+SO4LTaE/eXStku
         idA3Ez10e6Y7GDQL3Kd4/ajlusFcOi4RmwoKVAOS3Zy/h4NKv0j3/lvkf1NDNAvp51CW
         iulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598128; x=1793202928;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XlXnG5YdFZDLjnLxfZKMhexu3MIGr03hairmlo3RpRo=;
        b=YaqcT03GZP6+An/fGAa9so5vzWxFwTHwzIh4y7D1ityO/TwqqSNhWWpvf0hD1iIjQA
         Os6h/2x3w+E8md+5dxTOblxu6gSToaVp7WZIxcQihsMVE58XG4KIGrWvugNIk+KfORYy
         nOQ+KZNB93C6/IWjYgDxtQe/F8XAN6i3h6AzhyPHGGH8f8lbtdX7nAJn0iiTdtVDpzpX
         d+HjzSwU8HY7Ein05ndCYATrvRhJLgpePa+8O+xmmlUoEcX5Nrw9xgG0SV35vINGlEzn
         r8HSsaYvLmalf6nJHE3qoLerfpedD0n06C1co8X86ym8Oi4wJc9EKoEYP3VlrXHbz6Q0
         REiA==
X-Gm-Message-State: AFq9FYJ7h46850rBnODKZnNfoModKWh61+dD76i56ZHQt6BwB2q3YIgI
	x5melBJjolJeTMr67lmanYn8Q0GAvI3x2zeN8qjXFdV62YfVloGLlYtY
X-Gm-Gg: AYBFou1FiG/59rK8KBr3Cnex5XiGcQ8bXLTVxJg4AYU2WioxC0PHlkmKQueRpDImWIv
	cp5MTo9fJWcvZANRUcu1B/oxBM7ku31cLIABJXTu76OoNYQZuS86/l+22eR/T1yLY8a/21z59sa
	Xyb7sVlOOhVhxj/5o9LPzhNJfSXSU4GOKKsAQfF/D4Q/2V7NRJfK6J/eopTPVuT/GkfsNmN/BcK
	XwufT1mVjlkwMt6God7WWm7sJXEt7S5HlhjRQz6qe1UYShOlppedgqDVDkIzQ9Hnn6EEJkwHqcd
	11L8IcR0+08XykwdUN/HG+zPbsxYD/l3qmfj6N31ipUH2WYduGi7uaRCIP8YnyG//k3qpyIBJ6D
	E3tw0gYZorYYSmZblKpH4seXR016IYDBVi8yvSio3NYaY9JFdfQedezyNN6DNgd/m+OdNsczQyH
	vc9NQ5633TRrXc0IL3KIEq5SN2r7/PeL9pWvaxjKy6BMiSrshcKFgqf/T/ab5+jYuw5CJ14vpY5
	ZGrwozUVm1BVAHVNLrdEWEE3OlxdUWRBgMqGedJHJ+B+qKcJ/DAUDEip2vPgbfWU7l/56e0iorL
	OktWR4geOcMg7sky/tCSzPf0AuGgxg==
X-Received: by 2002:a05:6a00:aa0b:b0:89e:db6c:f199 with SMTP id d2e1a72fcca58-8a089f38e30mr1459600b3a.14.1792598127715;
        Wed, 21 Oct 2026 08:55:27 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08960fa88sm1077806b3a.53.2026.10.21.08.55.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:55:27 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net-sysfs: reject a one-entry RPS flow table
Date: Wed, 21 Oct 2026 23:55:22 +0800
Message-Id: <20261021155522.67521-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

store_rps_dev_flow_table_cnt() accepts rps_flow_cnt == 1.  For count == 1
the round-up loop leaves mask == 0, which is stored as log == 0 in the
tag (tag_ptr |= ilog2(mask) + 1).  get_rps_cpu() then calls
rfs_slot() -> hash_32(hash, rps_tag_to_log(tag_ptr)) with log == 0:

  include/linux/hash.h:68
	return __hash_32(val) >> (32 - bits);   /* bits == 0 -> shift by 32 */

The shift by 32 is undefined and yields the full 32-bit hash, which is
used to index the one-entry rps_dev_flow[] table unchecked:

  UBSAN: shift-out-of-bounds in ./include/linux/hash.h:68:24
  shift exponent 32 is too large for 32-bit type 'unsigned int'
   __ubsan_handle_shift_out_of_bounds+0x11c/0x208
   get_rps_cpu+0x12fc/0x1344
   netif_rx_internal+0x1e0/0x4d4

rps_dev_flow[] is then read (rflow->cpu) and written (last_qtail) out of
bounds on the packet path.  Require at least two entries.

Fixes: a435163d3100 ("net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KASAN + UBSAN);
UBSAN fired at the claimed sink.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
CAP_NET_ADMIN to write rps_flow_cnt.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/net-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df7578..038f7930544f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1088,6 +1088,15 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 		while ((mask | (mask >> 1)) != mask)
 			mask |= (mask >> 1);
 
+		/* A one-entry table rounds up to mask == 0, which encodes
+		 * log == 0 in the tag.  get_rps_cpu() then computes
+		 * hash_32(hash, 0) -- a shift by 32 -- and indexes the
+		 * one-entry rps_dev_flow[] with the full 32-bit hash.
+		 * Require at least two entries.
+		 */
+		if (!mask)
+			return -EINVAL;
+
 		/* Do not accept too large tables. */
 		if (mask > (INT_MAX / sizeof(*table) - 1))
 			return -EINVAL;
