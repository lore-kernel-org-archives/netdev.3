Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604170;
	b=BfBQrOzdLhR9h84N/15R2rpXLqNAq8y0X2en42mHYYsT2QPdZUM+ToMlgNugwLsRn1Li
	 s3k1jbmQb2iPSpEXRhUiaa2eRspVYbRO4paQGXDG52GW1zt6hDY0hUc7/XB6nHQc2d47H
	 ltEMqCiZoTx/JW/tNJqtRMcGiIHCg8KD/fhuFIVmke4stFjspW9k9oBQtBcw/sDzsYGMa
	 OL3XjBTfzjwnz/QDR1/ehzCdeS/Ptu/pLhXphj38LPQL+GBIjRhQohBH5OmLSyGW8zREH
	 beLG96WNhxmt1u0P6/eA+jpknCZsVgNwdyzpKgpuKVXFzfYGiB4i1b/VW5vpm+CP2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
	b=F0hF2eNvUtZqZxeWnhzzP23dBXbJMTnpDmE2YGxbd3jJGuS6ic9cv4XDjZdxBl5GBJmb
	 aLlERhUZj2YoXpYcrUOyD/GyXcGBJpJgUcq0l6MuDCJeVfmfj1JhLQ16LlVljKHcMNgCE
	 MStDGRCps7fGVwE/1EzPEVlZ+HqvLGi8wsSlM076tzIOV+4gM1QltQB6fgRs2JPQNVu3J
	 A+g/4Doh6Llo+Hg3vBsPpopLU3gUeWZ3RF2rwSzT4XfT8QMZrQBR9sUV1Gp6ypDM8mKrl
	 UvWQh9wIkUQeq2YqTFv2D4j3qHx5zQkPNlcg79Bo3q2Gj8oWbJseRwrTxrYv1+Ruh7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHQDVma4;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5D60A2602
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F5D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHQDVma4
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso914476a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604169; x=1794208969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
        b=fHQDVma42emL/UWszHS+aFx4fa7rns3WRGBd2Y4N4hD1nDUOU44AqJWhTKW7ACgkrE
         gzrNO3j4mRUqueiAYvIwpQma6EmNNzPQ/cdZwXWhs6z/hEFVmSdxXsW9SWdeqXeVyyo9
         xveIB10O7Ew8E0nfpeCDNsT08t6c2NMJIYHNFkhqrlD5sxuuQqVlTa20aIytyz0BHtEZ
         hFTOm3OJIhIQ0cxVxYs0EeC+YrAchQv5EnT6nqZhEPU4GTjCOaEN/7bSZcMfgavyHONI
         deg6ofEHyOYqWyMisqZAPUymUE/Qqjgbw0Tl1/9LzJTczyfhe0sJV8AYxiM6Z70ppoBS
         ik5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604169; x=1794208969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
        b=I4JpzemMcsfgp73ydxaxwfe+ndOKBqnwdj/nhi4C1rt8v1Pb8Xu5gGmX+yclBn6ePH
         Riuf/6U9vbn8Wy3Ffon+Za5IlJ7hsO2/+c3jTpRuAEWMrt8F+zLmjFdHcHudXg/kW1fM
         +sAfKlnHdsPN6hfEjqPge315tVu1nOCwu0vlKx9TEMJ8fK4Nr9n4JTCx7xV+3D2P9VhY
         cnPrxoyDs+fCHWxP81b1VEdc/5Hzi+MOC8tXyNfHSaakFaEej/0ZDxYE8NfS72SW6SrB
         7A+rbpDZxmeRf3CkBXPLHnq/wAX/exJ5BgFjKCmkGroryN1TPDtCcSvMnLgXjDb+iDPt
         OFFQ==
X-Forwarded-Encrypted: i=1; AKwUvByIyQOTIdaooXOSwRbqljTIuIMrfUqbbmMV2xD+hJeKXWA8aZ3WehVSC/KfrReLVdH8q6lNAxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fpw1+jYqwzGZyDxyM/ODA5ar1waUerlzpnEfViZVOn3JFywdl
	WNl57M1e/bPUt1cGTSOLlyC4jQccQdgU3wTTiDVEJuCc2bN273VWrwww
X-Gm-Gg: AYBFou2dWiMlkKT0W/i2BPNC0EPBEydfd8/T62kZiGepIIrl5rB3W97F4raJKx6WmFQ
	XmP7KVuHo0DwOyCn1n/xnxIdFnu/Rvpl9m0uHaD19Jd991UwGlJjJFwJJlQxEOagnVpDgDykBjO
	mOFl2xeEEB119E54K/tT7CnwjnbQZNzUqKO57W4dwHiabcEibDQMTbnrmDPDwXfLcEvzdhsEfCx
	ADOVF8HetpDVuPPQMK2CpGTC7Iu8alQSK+bpxtiY2r9+XWK0V+BCMcIP/V+PAVs6r4PDoIJz2xm
	lcdEGtihBsWGn0kcgwoI6m/4noR7/HJ+c5Od6yuBxBkBoyIDA5bmJXDXujKOFPsVln/wllcYiZf
	bTSWRkLho/MFwYQKfP/HfbZc+zAuzDFOy0I7foveyp/WOgQvbQGw6wo/TE+m2dpiIKp2jVoZw3N
	B+0zr9/GxnK91rSmdYx64TB9qqcIYmjZDEwzARiiTYaM93udAL+VEsKVgA/bK6VYWN2vSrgZsHE
	yZzgs9Ee6QSopgOShi4+rJF362tdj6TTo9Td0pWzCuHa4EY+p1Y6KFv8jAThiAamr5vicSJ3jVy
	Bfv7eLzHFycR0+qDwDq4gCcyaKjUN/SLJLN8Fpb8O60lujyTjX6CFMreUI0yMmA3k/sam8fTqbU
	yL2B832dnJQIfNcyCrYpSJVRJRKbmjo+d3f8v63CTPE0jvFPyRRZGscPdwleJK+AoblOnlHRl7c
	I=
X-Received: by 2002:a17:90a:e187:b0:3ac:77c8:ac29 with SMTP id 98e67ed59e1d1-3ae896f862emr6963704a91.15.1793604168982;
        Sun, 01 Nov 2026 23:22:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm3293330a91.0.2026.11.01.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork after a redirect
Date: Mon,  2 Nov 2026 07:21:11 +0000
Message-ID: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
the message is the cork. It removes the cork from the psock before it
releases the socket lock. After the redirect it frees the cork together
with the rest. Thus the rest is lost, and sendmsg() reports it as sent.

If bytes remain after the redirect, put the cork back into the psock. Then
the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
or the push fails, sendmsg() now returns a smaller value or the error.

msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
psock has a new cork after lock_sock(), the kernel still frees the rest. If
the redirect of a cork fails, sendmsg() still returns success and frees it.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b1071b0960cf..788ce08eef4d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -544,6 +544,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			if (!cork)
 				*copied -= free;
 		}
+		/*
+		 * The verdict was for tosend bytes. The rest goes back, unless
+		 * another thread made a new cork while the lock was released.
+		 */
+		if (cork && msg->sg.size && !psock->cork) {
+			psock->cork = msg;
+			cork = false;
+		}
 		if (cork) {
 			sk_msg_free(sk, msg);
 			kfree(msg);
-- 
2.55.0

