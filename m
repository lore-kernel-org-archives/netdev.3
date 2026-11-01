Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557435;
	b=HArJtlGOhP6tdiAPJLxIWaRrOqiP/cRwp5qqTDmOWCfwa15RV47tispHllPWw4BPgrR2
	 k91i+1LMHaEhvm5mYBGUA2UDBCC7CtrFz8qCFmxVMoPdK0AB0eFCk16X3//mMUVDOfGs2
	 rpGCMvtF6/URZ5axgFiQGi8ZZWXkGts44FSSlGtpjHcW+UH8LEMy5f1XfwcljXn2+o5nZ
	 HdU6CDdpmnomNJLvHuD2BtwHBMUS0zYTgif365o8K5CJXe+WvIFXymyhVSXKLndjLtMdC
	 vuKhOo9H5SVgUj8/5KxmO1R8cCPBm0oWKQ/Zg+iFHkmQzm31KfN+4dIUwnTqvszdvlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PousPftMuxge1de4JgtYSbXjOqqZ3UAm2KBK0fUdmuE=;
	b=YQWKuQuvF5q6rFJMbZVisjD0IX1dhZrtkV+HhKgYmpMmOx/zDGx41n70rmYdSHaoNGRJ
	 sOLNh8tLEEtsVdqjAxLNAFfIT/rfQ/v9I8lbcsl933E0PZs3l0TlF869JFWguoPQPD0Kf
	 jgENHiNsD9ijx5hjcUtk8BaJh3OY9Q/J5E8iSmyhxLhjSmFrIcIYGtgWTPwscx5BWrw+C
	 6tRl3fvMH8ho7aQbVCMn2fvnUu9gd5nvOe2fQRXCArvZptrDhkBElg94eUGLYcPwQq5xJ
	 x7WQLPDylN86Ty9n32MOajbDWdJxAkPgnPXfor9i6/hiSvKS88kZ4mg7ny+8fkybRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSFaeFYu;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E7606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 18:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSFaeFYu
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3493346eec.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 10:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793557434; x=1794162234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PousPftMuxge1de4JgtYSbXjOqqZ3UAm2KBK0fUdmuE=;
        b=jSFaeFYuK/zwL+ige/xGHmU4b5Ji2VCn1jiK5QiS2ac9ZOVljLBgogYTjdJtZeAvVe
         E6A/aFGnyDJZAEicrf9Cz4yQfDorfvGJTLIMlqgPpIh0Pmcd3hcnkQnOxitpF2/597lZ
         o25RBf8S7etBYJcRT4rputGTabU14ly7UIyemBAprUfCiAtZH1ssDoRsuJoCFz1Gwlzu
         sM7+6oyQuztxUNRLzhFhXTaTV8an2LUi69zW0xRIcvs07fgz6g5feOshuDRA5c9hztI7
         rQtG7FiY+Il4e61X0NIWWHRxVetattD5Ft+mXkSQ7rJymROdkFcR3LOX8lNDZXZiKcxr
         xD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793557434; x=1794162234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PousPftMuxge1de4JgtYSbXjOqqZ3UAm2KBK0fUdmuE=;
        b=fa8UmUJXyvc1cLcGdPIiAnG0EnjWgSlZYQym1VhpkFCE/yIXzgW3i7NNoAfUhTXs2V
         0bOBQI1K0Vz3494rj2XG7jTsPeRsrH7ArUCgtQxCpsDYJovAPAQ2UH+/F8o2g7Ki75FJ
         dYKteMpo10Z97mGbxZ4VuLQR2XKhzsUoi3NT0G0Yw5jOdI+KEclUel8uH9CMF/CpttvE
         4RB1FFXIRn/JzFNqpliGzuJrCrTUQufeAAs6vSJIQx3HG2k2Bf7e6fg3dRd6SDfpuIVd
         ZHj2pSPh3rtYPyGW74ch6PyGORhNHhtkNCaa/H0BZJ+hEFeWWO4jpKshNC8kogx9RCaQ
         z33g==
X-Forwarded-Encrypted: i=1; AKwUvBx0Uty0sc4QEj5Ql9v7ycwZ8I/WizbR2fXm3cU4Bz6mWuBQhcyALZZFxYVIgKFRpZ57huUxuaE=@vger.kernel.org
X-Gm-Message-State: AFq9FYILrogc8HhvWmM6X1CJmnEd7Ovs8dgeyTN0kwBAxj9O5Im9hb3y
	7MlLTZBwUmz0MXo+GWAtO9aHetrYCeBJbADmuqEhJJliJ2mNMxn0zJ4e
X-Gm-Gg: AYBFou0evKbpo7rIuvm/ZSiSiUIi6fMnUpOos3j3klX6baynvT5hOj5rb4EZuAZ5JKI
	ESkUvqD2Ggn3mERqfboWGrccaKFBtb9sEiGjlG3ijSJ/nR2ZXV9RvHj8fBrh6PKMcWpdM5w8DbP
	cy4hYwB/0gMPZL8n7o+hJSKhzoHTy+7/TzZxe96JSUl4SHsDAQEit2/ta2XE5Lnu3TfsNKF0ytm
	qMPqymj5z17XQ5HfBda8HMu7KvRuZ5/dQjYCBMd6VlnRGjNFIkONBjz8q38m7p+KWsiZ1Xnn2Qj
	hmw1vndHHH18QK0WCn3sezYumvro7LBJG8ZiWxV0SfXotSLpB5CNNnbwDyJT6fEgfwoUMVeBqaN
	/2y1OSzK/kOnnbmN0sVazIunoYd529ILz0XLMmRxOlTKX92+onlfUN68PyjZgSuS3NRiPLzu9q6
	N9tRyB+CX4dYhwHTe3HBswDiqN8UVgey9zAF06S5/0YVZo1i+9E24EC81iffZt+YbFl7wkrzbaz
	qXooeqvXk+gAViYaDEUTuIauoP54/U4PpUvbwkpjdWiq8B3Tv3FTSWIHQRlLgxOdreQIBFMVvqe
	6fyvEUOWHEN8tXbFRBhP5tjGPMKGpzvO1aEDxVSITuNoMJRc4bYkXqJPtzc39Qr3gg==
X-Received: by 2002:a05:7300:e9cf:10b0:369:f126:9ce2 with SMTP id 5a478bee46e88-36a42481f39mr14812550eec.41.1793557434277;
        Sun, 01 Nov 2026 10:23:54 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:50b9:9b10:1e19:1f0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm27298976eec.12.2026.11.01.10.23.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 10:23:53 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	ast@kernel.org,
	tgraf@suug.ch,
	zirajs7@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] bpf: lwt: Free the skb when bpf_xmit() fails to expand the headroom
Date: Mon,  2 Nov 2026 02:23:43 +0800
Message-ID: <20261101182343.17991-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When an LWT xmit program returns BPF_OK, bpf_xmit() makes sure that
the skb still has room for the link layer header. If
pskb_expand_head() fails there, bpf_xmit() returns -ENOMEM without
freeing the skb. Its callers, lwtunnel_xmit() and then
ip_finish_output2() or ip6_finish_output2(), take any return value
other than LWTUNNEL_XMIT_CONTINUE to mean that the skb has been
consumed, so nothing frees it.

Each such failure leaks the skb, together with what it holds: its dst
and its charge to the sending socket, so the socket is never freed
either. The other error paths of bpf_xmit() (BPF_DROP, an illegal
return code, a changed protocol, a failed reroute) all free the skb.

Free it here too.

The leak was found with kbound, a static analysis prototype for
ownership mismatches at kernel interfaces, on v7.2.12; it is present in
mainline.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings. Run-tested on QEMU (x86_64, KVM) with KASAN: a route through a
dummy device with an LWT xmit program that pushes one byte with
bpf_skb_change_head(), so the headroom check has to expand the head, and
failslab limited to allocations under bpf_xmit(). Each of 10 pings then
fails with ENOMEM. Without this patch each leaves a raw socket behind
(RAW slab objects 6 -> 16); with it none does (6 -> 6), and nothing else
is reported. Without injection both kernels go from 6 to 6.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    The runs were on mainline d135ab453a74; the code this patch touches is
    the same there and in net, which it is based on.

 net/core/lwt_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..dfb2f9253e81 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -304,8 +304,10 @@ static int bpf_xmit(struct sk_buff *skb)
 			 * made before LWT xmit.
 			 */
 			ret = xmit_check_headroom(skb, hroom);
-			if (unlikely(ret))
+			if (unlikely(ret)) {
+				kfree_skb(skb);
 				return ret;
+			}
 
 			return LWTUNNEL_XMIT_CONTINUE;
 		case BPF_REDIRECT:

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.53.0

