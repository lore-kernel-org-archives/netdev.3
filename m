Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560938;
	b=LoMDcftwdHuLwP42PyE4smIXBXiw0CKH/LCLsGs6KBXct3rWz8aEzdAkHJ4r7HYLBMlm
	 U7lZQm7XWpxCxrC/8hYgfDWeDgiT4w+H4MR2kkC6MipoojADE0jkBTgR+1721cUanBkkz
	 CBNqWmF+1JirVjtXtlfFu7/+qIfyKV1ZwxGUv2TdEZDsfmxVoWlhQv5nM6P0g7mWrwgwz
	 9HCQMzrhzGkcjXaCjWtXIT440Ea9m13zO1tK9QaBm8ncJMKKefWM9aVjqBZNOJ+ZYZmv7
	 Z/z70agotlQpJwFGcpCLsZJ/2hkU9+btvHr+S9g+2OHzbTj78Y0V+kMw7dEFycCxw0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
	b=ILQv1Kso5eo2Qy2O76dJm4/7m8kIRRjZJhTZUJeNk9F4/KVKH922F4Q/LSkstvRxlpek
	 l67scoE6eHIz6PjkEESB8nYpJLzK0MjfxB0OxYOAjIDkiotLT2RG/TSsq121rIEyugab9
	 anckTP4JqBM17YkwfFms7F+dE6buMOD1NmMk/X505Z/qdF1Mi6RNlH5XZaWV+LTIiwCNG
	 mpGst8CVgRfQKvIuH9IZwqfe+OmxpNLA8nF1+DtN/NZv2SKCkijzaCTHKLjswTiMGT3fw
	 s94x72cDc3yCiVKToCMKIqBY8MEIvRYG1siK1/tXSKZI7wVDJ893IK4VrI3EUoAQf1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGhzQK7L;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB7606A32E
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5AB7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGhzQK7L
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1647013a91.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560934; x=1794165734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=ZGhzQK7L6HUcJBrVHYYKo1IIWIOLyyDCWl8LfENkL/wRyYVVe8QrWSlYPPw1/QTwwr
         uYbuRaJeYVB52ObsGC3/Wfob6b2euKoKnuaq+HPdOkQg91wjXHRpLaJf9A9WyfjD6+g0
         tunAIesbX0B5iZGmaKp/smcQC8MmUvIZ2VVdTMA562HOkvkQgaeCCug1WyZcOKpstxUO
         zRMeTFfN66f3J4ts8I8u3N20aR0Y92IOR+/IfZ1XekIpQ9wdwAyrCeXhLnRTsaJipYoL
         86WtkcLIAnkBL7m8mDUB3FRei9uomVpyfalgnR+G4Ds//Yt27gIQcNY3UdkkEFs6knKr
         eVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560934; x=1794165734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=ye5JVSblXHrxQM+yFxwEqwv1fMryJvqS9yN/EPhdnzRcWhL4G/lfZuGNp71s0YDgy/
         /6L70KmV1JEukzWElLQTCIf95fNtkKZxOpvxE31FN5MdB60PK0nwhGfDu8QdA26zmQ2t
         lgONgIdjlsbktxCuMG0zgjaxSFv65MN1nsB91otYcd+rDukUl4VQnHWEWbCMjc8DIlKY
         zw/XpRyljMCjAE+ZxK69ThaYoH4raV7EXTaIc6enJ4rf/6yj4n5F4fEHq/JVuy0IeQiN
         vGUVOJXo59Q1q3vvFf1vYTB0gVjiSn5ErSBE39xtjEf9SmJwqsKPDF8bsJNk6Z/j87Wm
         tf2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxcABbX6Sth6KQ9IvHxR/AOfbl7GhjbfHiGHHVWCoNnv0iSazcLHmVMMtp9dfOrCLp/OZoVLCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oqBX+/zmJ1Ku2MFNJKGvw95VXOP7b/KSfYXCyLlN9XSq85aR4
	hK/VvDk33L8RQ7SsyD1gln9bL7h5WknBov1UodOUjuEjqPHOrDWtEkPo
X-Gm-Gg: AYBFou0n5s9808DiNTtbQj97Wm+wDoFYxpZ+e1GsyuHtMxflQ7O3Az0sYJntFYz52jf
	XiXwouXh4bqMuO+3w+kjGbALWMA4QtwmO0ORjLiVxX0n6MhQveP4X9mUwK9ioMnBYOx8DK42JfI
	+njSOdVJhoL6wvNOxVWMjK9pMJP+I2ox2G1TuEUllgMHL/ahhZH4hPf8nJ2PbAtwfybkwsE/esm
	7trch+7mNUbqf2LJQB+8bHJd5D2Z9lPtyhbN0iQmo/cV9pp9x0U7T9HvNVml+U0iL8J+WB3LYwE
	JYSrp8uysAu+K/rzYrlQo59xuaBWk2a3p7XR2tbacUnXRGxK3UuvM1JWG5gu2Wg9JfowHlLcrui
	1VvdwsBKkO2BPBf1gTskUe6aWlvYMEspvdb8xGjgyF+V1O+WRbq+MSyLuJx1J+q3JxPw9wJngdT
	pAvUYbo8m9C3IWqrcS5l9v0McrkghQGbhOHSRxRWJSy6l3Xm3EbI7JpZ/QNCSA4nldeEC3D4zc7
	+2T1OksL69u9odSFnG0MOd679tk1zmEIkW0TqU+74OMvKxH+tWfizjIiBsWFfl6WmFO1Jtrv0cf
	wqTgplP1A+6Vv5JuNFq7F0nW0e9hEtMZTONRcmacfTyM1jx8mIG0h2qVBATjRBWWm3gsxzW8uxM
	liNLt3hkYVqP3yAICQjCS8IOGqeV0XOM+6Z6gDHR1A90K1SseoCDRiJiqHuE8ftLPNLTfemuYI2
	M=
X-Received: by 2002:a17:90b:1c92:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3ae898166c8mr6711734a91.29.1793560933989;
        Sun, 01 Nov 2026 11:22:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f37e7esm6486678a91.1.2026.11.01.11.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:13 -0800 (PST)
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
Subject: [PATCH bpf 12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
Date: Sun,  1 Nov 2026 19:20:54 +0000
Message-ID: <20261101192057.2296489-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
again on a cork, and on the rest of a partly sent message. Nothing clears
the field between runs. Thus SK_PASS without a new target is a redirect to
the old target. If that sock is already free, this is a use after free.

Clear msg->sk_redir before each run, as the skb verdict paths do with
skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
sends the data on psock->sk. Then sendmsg() can return another value. A
redirect that applies to more bytes uses psock->sk_redir, with its own
reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.

Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a5d498982848..8a3b8536c0c2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -936,6 +936,13 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
+	/*
+	 * The prog may have run on this sk_msg before: it is a cork, or the
+	 * rest of a message of which only a part was sent. The target of that
+	 * run is not the target of this run, and the sk_msg holds no reference
+	 * to it.
+	 */
+	msg->sk_redir = NULL;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
-- 
2.55.0

