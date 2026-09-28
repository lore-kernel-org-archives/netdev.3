Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AD3C98BF
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621958; cv=pass; b=fo7S5CJ2PGx1aJrR0CAhYNfoMmoEmZ/u/B6hnZlEtc+HYDqCXLhkLtcfOaPQfTB3UJvHQiKUU1A7TDP4wZActTxz6J2YsSkrkbzPbxyE0HepjpIDwf6npmxLkRZ7CLp2A4hmqHShVsZaPtiH5wqJp6J9nKWyLGIEIudhR8Rfszo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621958; c=relaxed/simple;
	bh=38U1s8GZuYMNUAkuLxbkuCyOG+w/gVbAI7eJbWfyuKE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sHEpmoF9jw7wj8orCdGQWmeNZhNKnA7DSrt+44yJTnTofmjfQA36PYHFYI23Ets7fiTEcltzDqES6m+XsfeRRgqP+ooyEmY8r7oueK9zcPxPto6vJKsbKnGLLSY5NHhpO37GRSSl/2R5XOS7v2YQnTsmGF9hWPqwFkWuERMsuas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkVMQ9Cn; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkVMQ9Cn"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c7a1aeecso3068992e87.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621951; cv=none;
        d=google.com; s=arc-20260327;
        b=Hj4Vbg2JXfG4DHeOOsUYrveI5BfRZppx7Yj7UN6ZKhchc/S6/JRhvoqdMBYKs7HX9l
         U6iMFku6J8AnrxqGeDQwLxqUzTcNbUyD6xuyFhy4k1+UmXFXJ1Ij59b1fPWXYCPCPeNW
         fKImjUTYwFbWPdVUXtKirlo8uP0d1K7MVYbzjxjF0qWc7kt0zp3a/okTYnsknh4H5EZa
         Tq8vB06/A8VqKEOKIoDUyXlzBUZuMRi7l9BT0a80Fou45LaHka/rG+qbSa7116knR420
         jN1SmLAvYumWqEdCp0lDC4ZVyJhs3QSW/B2N7GUGHNMq6CZs+NcrZltSa70UfrO9zeDs
         oHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        fh=6jge13fqshLcVuzryPAowlJAHVUdDCWfz/oE4ekl82k=;
        b=HdwCUk6ptTZSKdS+thPgzrBi/LmQZwQqlGgKj78qROVAjRnEeX+ntmkVJB1PIBrLcy
         jjyYL6zSdLsZToiSnYVwl35LjgD+R11ueiUSPI8lCgjoKrGpDpOUimKRWzLuqMNbx9DV
         mP8vsWN21i1YEZtHl/Jyeb+fpsKnG3jhbhsCXOv/+JzSk+qqls6t6vr8WXJCWTc4djM+
         bpOfFW5/P8ffYrIrfTgzkUbT/Q8k4+RENG47IVplcs42R+ljj4wCXk3Zb+ztNBHKbi0P
         VKSrBQmmsgU+5Bqd5l35Ac0N5h+oAU1dYPOMHpbfmqXQmqRB5rCGFXYe0z6DNMhNPRTf
         kKpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621951; x=1791226751; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        b=ZkVMQ9Cn4o+jeVoWjjCwmq9CPcWR7/mF9yEG7Ns8vm6qxN6Zxr+3S2CeeJ376BXJtz
         GVXAUUQC4m9e5XNrwD3kDMHErMmhNwdXdhjazklqN4PdGNuPuk5BjCf3IriVDoTMLJEx
         YedorAfXg4T0qn6IGn3W4qmJpR7e2meojy9B53opjP7/4gbT2zvFH0vZ4ovTuE5/0owt
         by/DTUHfyIoqxLiBI86H8+MjOqF2ySzbHzAQ4QmIBaPyzkHysb1yUPMCvKOpXOEWIdtP
         fWttTVU2sH5IF9JhWLDO1iSE6HlySw/mVz+kv66d15ZLkztjyHkh9Oo3fh9BKIXMlNCP
         oWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621951; x=1791226751;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        b=JMNHyjdvoAwAEIXVotT+GkrtU31vfWr0632vnkdov7zrsdjTXl2Cv3JS1MzrzAnUZI
         aevLDbO3madMefJaqp9PWD86haKXc+d2pGtYDnnS84FuzfMSIyCwRi0CBv8euYvbKU/r
         UDwCczRsPRrOLMOc1LdaNt9nCRplVK+vMDV0dJRYD2Kpe4oJKeG8upy1mkn3aL7Xjb7U
         vNdQb+Yeg78HQQ+opG00/xeALPLxsBZIwPTmTa+aRESCuI6ZWx6ikjbu5lnhRC6DYJiv
         aA6n2FhJ5s/XPpzCC4j6ddx91O3fwU5t5GS1SAxbbqzkPFdCRyFEuvS43mS4DkqcFiFq
         ar9w==
X-Gm-Message-State: AFq9FYLMRP/yLWazkNTeyUmkXNk7+dyxH0Y2wEQPz83xE3UZB4xm9977
	vle7J7Mgr+M+CZJOFyn4BNut1V+LYYaOV+HWpNfocriqHYQZ6py/dJEFKumtXk3a9T0RCZrtyM3
	SBs1jtKADs6zrVhQkKytoppmv63pfZ/+kdZZwSwg=
X-Gm-Gg: AYBFou0NaWTHiaEnJI4yMNxKKsMnOTY8pNeP9QdE6GqCwggGz5zsUGd9fzYWN8WYVxY
	Xbj0haA0o+VqDPqKU1Rpk68Z22muA0pmKGvJahP1+3mxW5WBZfkw+QFzpTgaMoy/wbbltgwn+h/
	sNenF4ksNTaDpz6tKv8+KN++kQU1vErCKu9uQtNeL7NzeImnyovwPbQGCxcBktBJ739KajTBE4p
	JHK38OsAb+eHjePHh4Tbni+F1um4Y+Mm+cy7Cixqlfj8XsTZKoKQEKXzBatF19OJJvWaIlpN163
	85IEISlwOgZGeQZ/ciRz/4sAbMfv5SL7PecLOMJSN4/9MJpJiY828A5nLeQuG2uT0m8lFTmRCyC
	w/SnDro3jLQ+j
X-Received: by 2002:a05:6512:a87:b0:5ae:bd5e:95f7 with SMTP id
 2adb3069b0e04-5b8df0d42dfmr4907670e87.4.1790621950890; Mon, 28 Sep 2026
 11:59:10 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Mon, 28 Sep 2026 11:59:09 -0700
X-Google-Sender-Auth: bfjEdBcSXwRUi8bLWiPkOvkvDYo
X-Gm-Features: AclHuK8baSSkZv-tT7IrQBt-8uVkNNdEXmB5RveGyZwqKIXYr-qkBIj5G0AoAGo
Message-ID: <CAANnmVAicVNhy8fMUaFJ_N+b4DnbwpYi1MOL4yMVisix1WCX4w@mail.gmail.com>
Subject: [PATCH] net: ncsi: clamp filter table counts in GP response handling
To: netdev@vger.kernel.org, sam@mendozajonas.com
Cc: fercerpav@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	gwshan@linux.vnet.ibm.com, joel@jms.id.au, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ncsi_rsp_handler_gp() iterates over the MAC address and VLAN filter
tables using the counts from the Get Parameters response itself,
rsp->mac_cnt and rsp->vlan_cnt.  The arrays it writes into, however,
were allocated by the Get Controller Capabilities handler from the
independent rsp->uc_cnt, rsp->mc_cnt, rsp->mixed_cnt and rsp->vlan_cnt
fields.

A malicious or buggy NCSI device can therefore report contradictory
counts in the two responses - for example a GC response advertising
a single unicast address filter followed by a GP response with
mac_cnt = 255.  The GP handler then memcpy()s 255 MAC addresses into
the 6-byte kzalloc()ed buffer, a heap out-of-bounds write of roughly
1.5KB of device-controlled data, and the same applies to vlan_cnt
versus the vids[] array.

The loop indices are additionally used as bit numbers for
set_bit()/clear_bit() on the u64 filter bitmaps, so any count larger
than 64 writes out-of-bounds bits into struct ncsi_channel.

Clamp both loops to the number of entries actually allocated for the
channel and to the capacity of the bitmap word, mirroring the
validation the SVF and SMA handlers already apply to their indices.

Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..fa1ed405dfbb 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -883,7 +883,9 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	ncmf = &nc->mac_filter;
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
-	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
+	for (i = 0; i < rsp->mac_cnt &&
+	     i < ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed &&
+	     i < sizeof(ncmf->bitmap) * 8; i++, pdata += 6) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
@@ -898,7 +900,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	ncvf = &nc->vlan_filter;
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
-	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
+	for (i = 0; i < rsp->vlan_cnt && i < ncvf->n_vids &&
+	     i < sizeof(ncvf->bitmap) * 8; i++, pdata += 2) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
-- 
2.47.3
