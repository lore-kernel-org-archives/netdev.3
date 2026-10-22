Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671378;
	b=0HuWCNLAwAdgXjWWyMdvIJKLSJ9hj5Fx2/eSxBztOac4tIbzl2DCzP73X5dr+sHwbmv9
	 A4wmMTw2OVaL9oG8dW7StjH7rWrplezejDZ1+NyNgveWspODrwNzjD/LobUaCc7Ahy58D
	 5TPt7lWDUlpsCfMei7tVPcHJt5rr01ly9ay1C1yi+nzA/pAEsKdWpcBf2wECPO/Y4xlnp
	 CT4BbuclYzSz0fcxSSWwjbCxRkiAB22lBdCqnPYduXqCJT/1vGVXiXCetleKjg/06OFy0
	 UQOuOPFmXE4TP0OfVvRGiL6KxRgXxAwQiASCySJ22jBAQ8l3iZdGtEeq2YH8+ccrbUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vNLGOZBo9M0aOiQpNACAMhNlgQd5Qz2fgrOB7kzhT60=;
	b=aaU3O5hIVArQFI98JnUF6KjKGTBNXXkuLNX4JxGgdBrDThP+nP4QEkD7ypvaoqytFzaq
	 tF6iVhC7MPymFl8iYvAayiGSLNgb3cujCqvG8U8jZz4NO8SeqGEOF7O7NgrzKzAdasZJ0
	 imDw+ObOf+upB5dyfy3qA2PbZ0cbzQvL3naeLw67Cyoh4FxrfcYncPinlZxU1lJUPE5C1
	 Ql7jOiVgOQLyVbgAzXOgB310heAXAk+jp3kFRbqpYzfHblPs07JZOnrPIYrwisNCUtG/y
	 kHLca8/9Sa31/yhIDJL1cLRfyZKIfdNRc7MMw1YIr3fUYKJ3LWbJcSthXFbyahk3QUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b="Tc/6I9Of";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2A606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tc/6I9Of
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso12076725e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671377; x=1793276177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNLGOZBo9M0aOiQpNACAMhNlgQd5Qz2fgrOB7kzhT60=;
        b=Tc/6I9OffOf9w2LXboWwsWCTHaKzntYAwzcPu9ZHb2El9voyZ6Qsyf0fmk02pWVPlT
         rWBChZJkR3gbwIBQhYRFyrmEVKoX9FBmGpM/IU8V2hn0ylzhnM086q08+BgN+0+hggkv
         XvXUsi4xnKrjim9LSwL7ZxUizBnsB21VUpzZCxfeyx2MZldf56Sj7ZV2lYzDOik0M6om
         qW+0evrWu9XFiHQaRcqPhfyB6qkggXdLH3Ycovfh3miE7ad0B7OzeYk9FUhHleCXe3+z
         CmWHtQOR+VWyopeS7UJMRXWgo6PatEgtpp3PF25c1K+6z8Q3+iscdU+RJNk76/QP3ikC
         nTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671377; x=1793276177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNLGOZBo9M0aOiQpNACAMhNlgQd5Qz2fgrOB7kzhT60=;
        b=ZRkBJxclirv10fIOPZ6ALnkTZVy05D8RpnBjNW0szyQxeAlti4Oez+V0m55KGg4ZQc
         5EwvpBdkSrrGnMnTBqbYpW3gNDYX/6a9dxZ/xOf5XU/I4eSRRonGRvZzgsgaxQs9GVrq
         uOsVqG8BMlaxIoWABpRgYaSMRNwanRaSaRC2ThdD63D6Wc/5SiZ6fNLzpciVPWZWcUzg
         rZOJCkMWBiZIRd+NLyTgtkswRo4rBEGdcLqUWKA4VbMK+aUaNeDHjSsHF2VEfAi/lGx7
         e+QcWoJfP5SrbNkAa2s5RqlxtTO7oUJ5Dtrg61ubF4oP5+jDh3NBA9Sp5ktREQEAvBum
         O9Cw==
X-Gm-Message-State: AFq9FYIzB7IsOYpNuXkejCQAafiAuPZHvI9EZbb24YXOIOcWiIGqzdo0
	0PMkk+AerM96Dkb6ILxW9Q2lU+AUW/2rD+ijj8c9Ne9ZJikM94ievF2CDhr5McA3nZRkyrsn+F4
	ajvdXWBnyaysEZlHFgO7/Ocgo4eSDjUpNzOU5FcoAlP8h31QTU2D1AuRB0s+aOmAdm74=
X-Gm-Gg: AYBFou18All0NliBgvwnQUB7v25kKLHEld9XTq3ot5uqbtzf9c9rFUCuMIy1wNombjm
	dYNziByCZYHGuPr9mfO9CFSGLfAR84WAs5qAhYzLH4VIpIfYgD8BQGD6HdwKqKogCRTzDYZh1vh
	Zs/HOzLx/tLYg7Sz/jDNMvulhpQW4axVUJGMPWWey2D/DrnAHbL6a+8W20tETYauuSIYidm8t8B
	OzIIumArqT4ZGDvVkTQyAehTiZpgB7aegSuPaW1TBra1F20z+XTzhKwvKDPqGF/qfxC6Otm9GWf
	KgYU0t8EnJC3TxEkXeyKEFC78SFsfXI5sxUMuB/wXVs28ZQJafrqklqm2ROzOyz5Wac8mf6BPM5
	HTRyplBIbdde6YY80/4093Zg6FHNPlfWye+bcRdBWNOWXFlr9zhWNLL5qq9i2GrdFAeJY9A0N6j
	UMVVmdp4rkjyXx6k2uNFJIckLkmXW9bJNoUtCloPuoO9kbJR7Yp6Ew2Owx0iw0X7ZdL+nl4Ht+c
	sHUPrf6ndXcq9ibS0abNcjnDFIGqaBjgrInHQnc+vJDJvCebv42KFVFUqX0UfBh9Hw=
X-Received: by 2002:a05:600c:e557:10b0:4a1:6991:36d7 with SMTP id 5b1f17b1804b1-4a1fdd20ca2mr62839025e9.10.1792671376937;
        Thu, 22 Oct 2026 05:16:16 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:16 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net 7/7] selftests: ovpn: avoid calling freeaddrinfo() on NULL
Date: Thu, 22 Oct 2026 14:15:50 +0200
Message-ID: <20261022121606.732029-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

ovpn_parse_remote() always calls freeaddrinfo() on its exit path, but
result is NULL when no vpnip was passed (with or without a remote host).

POSIX does not allow passing NULL to freeaddrinfo(). glibc tolerates
it, while musl dereferences the pointer and ovpn-cli segfaults.

Only free result when getaddrinfo() actually returned a list.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 3b612a8a18fe..ce9436f92b43 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1849,7 +1849,8 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 
 	ret = 0;
 out:
-	freeaddrinfo(result);
+	if (result)
+		freeaddrinfo(result);
 	return ret;
 }
 
