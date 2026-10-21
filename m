Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598080;
	b=Kuy6weddi6JHpL3y9P/srhYbgTNLl3Hy6DkaG1vl67tpN6uxbHT6jWWobLQpFoP6iJ/9
	 8hSJfjGSC7y0DLCFUH72eV1o6N72/EPeFBlke6yN9il2vhbzKyk95QXg6mBP6va9Msz4J
	 XigE/YYOoQi29nrvSom8cS1urek0lsdjCKejMHY+Gml/nfTvbF3/Lu83cbWuaU7JDwOvp
	 G1OXgX7llvMqj7HaKfW7owMhiNyd1Ql80CGdjO0efJLal7hwri7rIrfXe8r00uSjqAPuq
	 esozssm5sI/R52nWTUzf3UuKZ0YDf2HVCKXgBLCbBf85LpUjciAYoMWnwu1tpQ5GRfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wjEig9clHR6aSVdxUT5EImtsz/5Z13pmefiOyn+eLYY=;
	b=a1uBqaQZnLy7aDYltahC5O9WpBO1oPdKm/u0O+oWhzzjPkwada2DesA2hLgxrQpugKhm
	 eq0TqWzFoIq/UaMnQByAlFcbTordFk+DSEhRNGE4TiRibB8edovyISZHFLavdjm2foViM
	 exVYdB1Lu/uBRycQJuC/m5BxGDqclfvBfoZx95xLT5PH8b8Sb6OyS397sgShckRSdPTPB
	 k0m83vMOc39UlsfCvRU+t0UehQrkc5a39oZqXn/Toe7pDsPTWA1ryKWQmjBFDZQTZkzvi
	 LqVAhdfR6476u5EPZnDsOf3ee+ut7LIGJ/zspKYjjacT/zuC4VO5efNTjj5dC1Di4rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lTadkrYi;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A4606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2A4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lTadkrYi
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e831e86ebfso5090175ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598079; x=1793202879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wjEig9clHR6aSVdxUT5EImtsz/5Z13pmefiOyn+eLYY=;
        b=lTadkrYiMRc0uaYYxJ07adNpwg3iR+wHFyg/0ElZf1jAjjF/N02uvNuJi+2BUwcCGC
         Ru2LK9ag9idsM17vk5uVPDIoi+gevI/kKY69Q6+9fgqeEdu0ef+PVHkW7t9adEmjYNgh
         gKpiOpYJkVnPx1f4USj0Y2RcN/7OCkPoI61y6qPC9Fd2psqaLWq8Zf1G7IkyV9lwY+6p
         Hb9z4xtSaHYRD9dR2N7SwEsveDZizKcZHb177NppRWwph6xW5MMoSL2nNQoBzyd7kVDR
         R9VM0XDqJsMKLqh+ttFo1TFBRTy71Zjqik3FN31odyKrIP2Tog6RtOYxHBwqcPDdP6xC
         WZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598079; x=1793202879;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wjEig9clHR6aSVdxUT5EImtsz/5Z13pmefiOyn+eLYY=;
        b=sG06ulj6SgQnUhShasADZfxOF7jpomGEOcbu58i7gJvqTjYqfr5+bifoMLBZMuw7zZ
         +4l1tZy1JaEnk4ceShB12nE5o7ulgNzEwNvgg66bmXzDwc+SmsA6Fybfypi7u5s/vaI6
         H6dOiEIUycEkioBb1xcL5HMbNXeej3Y41woZ7B0MBh9U/55PahQFi9QP4pfADXK2v65p
         ymAm8uM0z+R2fe3AMLDZlpB64hxvaR9JYCIG+dh8fxWTm3HsAVuYURh6PxUXscQMTm8d
         z4u9MGMApHVTcR3AewkBbazsviSRO2RO6GCHEERA5O4Pw62D1H2/vbPu6WvKjkLdh1m7
         4VQQ==
X-Gm-Message-State: AFq9FYK8TeLdmGoIhMUALYEdUvitnGaBdXKHdei6ISOXLTIeUg3nqTLd
	zTUkHt/u6vhC9zZuAkDAUxevHgSUbZLqtNO/MZgZvoXam2CEJouazK17A1KgXEdI
X-Gm-Gg: AYBFou2GKxuvbynue/nvTo9zYHE8pHpHkPxIQ4N2TkJmBTRM9qhe/0vrnzbJUBf/wqJ
	5TySOXeCWDro7gzwR2J+3q20vDBjrb4/ljFcfMV/Udy9slsWC1pU/Ot4VGH5CZHviHC2LaoD2KL
	4saza6BCw/RO4u7go4W3uxo8l89AcAxJ/XAUPxGEvYcyCzQ1NV+KiOxTKlEtPxh2mC7Blr/BhTp
	Xj2FEPSVd518jpJSwFIWAco+NKeQAmNXpjHVyWvWMi+zsszN8V5tUyTUJh119tX743tP6N9uXWj
	yLrVpfgKOTnOwLip6dK8oBc+zaHSCWFRO+V46J/u9Am9z+8mrq/ebRINnEPb+977Vd5uBqdvR7q
	CC3+Q4GdFP/pinbMfp1sUBBmTQNIRAfuieR0DED5wRL5hF8eULiu2wBNQIyj/n7tJVpPeAoAA3x
	KHLTEI6b7DiwJ/wQGFLl6oa8yyh7h2HmtzXKrhZ9/zjsnexV73Avx0Mwko+oHNS17EQQAyGPEYB
	5iGI7u32M6Yb1/mjN1jBW1lgqyncwquFCGlCrVDBgLyHaMBj5WF/ZR4cGqNUHC8K3lR06Z7LhFX
	W+wMTf0FMejCHVt2HWEKohZfi0lxaVv8B26bUXy8doBsH+CtyM4iQpWiYnA=
X-Received: by 2002:a17:902:da81:b0:2e4:4eed:5cc5 with SMTP id d9443c01a7336-2ea439da841mr21175995ad.38.1792598079292;
        Wed, 21 Oct 2026 08:54:39 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b41096bsm13893475ad.26.2026.10.21.08.54.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:54:38 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: gred: keep the qdisc lock while updating the table
Date: Wed, 21 Oct 2026 23:54:33 +0800
Message-Id: <20261021155434.66572-1-phx0fer@gmail.com>
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

gred_change_table_def() publishes table->DPs/def/red_flags under
sch_tree_lock(), drops the lock, and then keeps writing state the
datapath reads without it:

  - gred_enable_rio_mode()/gred_disable_rio_mode()/gred_disable_wred_mode()
    set/clear table->flags;
  - the red_flags_changed loop writes table->tab[i]->red_flags;
  - the shadowed-VQ loop frees table->tab[i] and clears the slot.

gred_enqueue() and gred_dequeue() read those same fields (test_bit on
table->flags, q->red_flags, t->tab[]/t->DPs) under the same root lock on
another CPU, so the post-unlock writes race with the enqueue path:

  BUG: KCSAN: data-race in gred_change_table_def [sch_gred] / gred_enqueue [sch_gred]
  read (marked) to 0xffff000007ad3b00 of 8 bytes by task 110 on cpu 0:
   gred_enqueue+0x88/0xc60 [sch_gred]
   dev_qdisc_enqueue+0x4c/0x19c
   __dev_queue_xmit+0x10a4/0x1ea4

The comment justifying the early unlock only covers the DP-vs-DPs check,
which the shadowed-VQ free loop relies on; it does not cover the scalar
mode bits and per-VQ red_flags written afterwards.  Move the unlock below
those updates so everything the datapath reads is published under the
lock that protects it.

Fixes: 6639607ed9de ("[PKT_SCHED]: GRED: Use a central table definition change procedure")
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
A reproducer was written and executed on an arm64 QEMU guest with
CONFIG_NET_SCH_GRED=m; KCSAN reported the race at the claimed sink.  The
reproducer source is not posted here per Documentation/process/security-bugs.rst;
it is available on request.

Triggering conditions
---------------------
CAP_NET_ADMIN to reconfigure the qdisc; the race is stochastic (long clean
stretches between reports).

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/sched/sch_gred.c | 18 ++++++++++--------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index f04f425c6c44..f3d9a7252949 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -442,13 +442,6 @@ static int gred_change_table_def(struct Qdisc *sch, struct nlattr *dps,
 	red_flags_changed = table->red_flags != sopt->flags;
 	table->red_flags = sopt->flags;
 
-	/*
-	 * Every entry point to GRED is synchronized with the above code
-	 * and the DP is checked against DPs, i.e. shadowed VQs can no
-	 * longer be found so we can unlock right here.
-	 */
-	sch_tree_unlock(sch);
-
 	if (sopt->grio) {
 		gred_enable_rio_mode(table);
 		gred_disable_wred_mode(table);
@@ -474,6 +467,15 @@ static int gred_change_table_def(struct Qdisc *sch, struct nlattr *dps,
 		}
 	}
 
+	/*
+	 * Keep the lock until every field the datapath reads (the
+	 * RIO/WRED mode bits, the per-VQ red_flags and the tab[] slots)
+	 * has been updated: gred_enqueue()/gred_dequeue() read them under
+	 * the same lock, so publishing them after the unlock races with
+	 * the enqueue path.
+	 */
+	sch_tree_unlock(sch);
+
 	gred_offload(sch, TC_GRED_REPLACE);
 	return 0;
 }
