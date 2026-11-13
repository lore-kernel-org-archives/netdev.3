Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598618;
	b=ncwIfWIkC96269BxpwEFwGP7572cOmSMqmmrXvIH/Q6/0eNbrzXCBiXcO8O17I8OVUs3
	 UgekqDp+DhIRVGKMfvcVFpOOpdin8VlwtdaAy+fIoGSqGroSYQNgAVcgEXAW50116Qf/z
	 qrzdmAFYUNyVCHTCW2iAeQQOMwrkN4Cx+swtqZcuTEYC8Izg7bwZ/A55so6u4DXa5UaOo
	 +/l/++IDYx6USUZU79L9lXwgtoi91XvOcNft3dkFV/g7p6aTI7QPR8pVIQ1+/8zI4FCUR
	 LzkT9cTzWEg4//TAu2f15T27FC59J1dsjPOy35y69VEYBxqnAJdgEbvDkJthYNxVtyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ItVvwZvGG+Kdi9d+txCXAOFgDEf2Km9Gecmc5ltb+I=;
	b=WR/fF5QUuDAQpxYX1N2djpAMi4OWvtmxWS90bdt4pWNqY2OpZnJvgqJTTHFbCz3ETbRG
	 mdxY37Xts/pPiDYKteG/8KSwIh1lG+GDxfi0yXdAlN2YkaMCgz4WkmY2AuABrT3sasNSP
	 OcBEIiH3pwFz14WcnkQqWh3YN/q/RVaSXr/AsfIIrZqzyhf0cWurpls+kLcXcGhuZecZV
	 Mb6kWB4+6ZqQpk1TQRgi4pwZUXbh0WubyYT56XzNoYq/IfFv68xvPGLu6Mqje7as0zTg2
	 YSkh7hchWf58gADOjEByxxe9xp4/XAb0Mjt48CCbXoGB83sOJEoqXtLU9xpZX4mxRCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=a6XZ0mbD;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5E606A333
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE5E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=a6XZ0mbD
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so1400120d50.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794598617; x=1795203417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ItVvwZvGG+Kdi9d+txCXAOFgDEf2Km9Gecmc5ltb+I=;
        b=a6XZ0mbDy0pgWyfRlQvkVd+DzgenIvgbq6yL1LHALdWgeL+295hESdQZlopkRG42Lt
         0Pu15Sqs+b/6IT1wCo+dtPvB13ZvLdHsmAdQz8S09rwv3edtSC/LYENdEsT1sHPfIhB4
         xia7L/H5nkYwvFM+fih6j7iCMMA/S0c8jLU0GJb7WY0HKoWJrh70w+QbsTXhTjpBOmkT
         rfrTpPNlbfp5Z9jfzdya0+ugEcq4a21OlGLJjQTC+ECWMbL0yJcnx0JpPNX3AhTWsp+e
         8HoSytjaNSKF+NqPBhekVyu6Ys9tU7P5xjeAvPjfxlV1U3PJFaidZwIwx/+Nh0+LAspL
         Iasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598617; x=1795203417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ItVvwZvGG+Kdi9d+txCXAOFgDEf2Km9Gecmc5ltb+I=;
        b=m6Mlf1Omxw9cVLaaL9xoS8UIVRH21+ocRG9/6HGitIgK76FbZTV54wWSgl4quoc3hl
         5EySRcWUzlBlPn4PlJOb1DeFoubw9TlL9rtVVzRypGQVbIyFdoD6mNJTgtyegv77OGSA
         wuhWxmDMDXk35sW6ie1CSoISiXoz7x377w3iZjkAXy9jJAIasJo3knfSSSYhuBf8ADBN
         EUJtcQllCpRbhOZsKfHKZcXl0V7XfzubtllvohtPJgSZxSnEczIRPOraowdXCwzhDDSF
         +0zbJHl3PrqgaJpLdEeWP2s3D60hZXRF7cySHW6S9VS9B0cPIc2BtGwcxRekjGnDJ028
         Q9ug==
X-Forwarded-Encrypted: i=1; AL+hErFQ3PBbC/t64yn0svtQQ4pMX+6MlueCE67bKAUvmzpo8dkef1f1uAzYCF451saJ+Sk991CF7Zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WiMZ9Yd6aBOp8NcBvK9LT+aIJd4Psp47UvpgFZfsItOIe8Pwz
	8GZvSeMX/ci+1A4DXGILtKERgVkgySzOlMScsy00yao68cLEzEgbZ+tObpeXy5WxITiSrSlfQXe
	HTgE53tBS
X-Gm-Gg: AYBFou0yUs7eujZYayX705U9+lQ55Bzb6W4TbVRj3pPh4kFUCvmBiqfeAx7oYH1byoP
	WOP4xs1V+99IZWwJO6c2koMFs+YmfnrENHLb2UdExpKwjqY+kQqvMEx7U15XtNXDuZCUkRiqC8e
	riWpSrZ2QFyJqMsC4hd/SYGsvL/YhVW3Ip1zbcSfcyt19EsFctaX19IBV+zVlmhbqHd+y6i7iKA
	XSHqvDVmMXGyf86F0Cjvq5Q9iy4lvaqk3KoTm3u8WH/J2DxnfbwiFYaxM7dKRTrTOvT7+BqQj8h
	B8IVilzVDouQdZvsniLnNU3YCob3GxYGoqgJR7nNOb2jJ8Tuw4shSXOJt8NHnr3citHbJxSo/oP
	YUJr+QyoFTAw4JBOkA1n5LXwVxHkhxQznPR7logLhb2bbnnlALpxCs1XnU/7qNAMzYnpUg2/I4r
	3ZWkGIFFKNBOrmAFu1GCz62qKnr33wwXBITejy8QUuOmhMf11a+Tp8tdkydDKaRPytkLQIIH8mO
	5PwvQTj2RnOYg0120bAhLaBJAZjL4e5od9jLgs0PjPNF+4seTVHsAQk74mFxX8d4O38WRS1Zre8
	L7x5y/5Qh9vGXqNBhcQAVshv+it1mBpBYdNK6/Rl3Z0i8h+3NHY=
X-Received: by 2002:a05:690e:140b:b0:67c:175c:df7a with SMTP id 956f58d0204a3-67d895a7c36mr2662489d50.37.1794598616814;
        Fri, 13 Nov 2026 11:36:56 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a5ea356sm2845680d50.17.2026.11.13.11.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:36:55 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tls: fix send() returning success after the TCP send failed
Date: Fri, 13 Nov 2026 14:36:48 -0500
Message-ID: <20261113193649.3822306-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit b341ca51d267 ("tls: Fix tls_sw_sendmsg error handling") made
tls_tx_records() pass the error of the TCP send to tls_err_abort()
instead of -EBADMSG.

However, bpf_exec_tx_verdict() still looks for EBADMSG in sk_err to
tell that the record was not sent. With any other error, the record
stays counted. As of now, send() on a kTLS socket returns success after
the TCP connection can no longer send, for example after
shutdown(SHUT_WR) or after a reset. Nothing reaches the peer, and the
caller is not told.

The issue can be reproduced with:

    python3 - <<'EOF'
    import socket, struct
    l = socket.create_server(("127.0.0.1", 0))
    c = socket.create_connection(l.getsockname())
    c.setsockopt(socket.SOL_TCP, 31, b"tls")
    c.setsockopt(282, 1, struct.pack("HH", 0x0303, 51) + bytes(36))
    c.shutdown(socket.SHUT_WR)
    print(c.send(b"hello"))
    EOF

Before commit b341ca51d267 ("tls: Fix tls_sw_sendmsg error handling"),
the result is:

    OSError: [Errno 74] Bad message

After that commit, the result is:

    5

This patch will make bpf_exec_tx_verdict() check for any error in
sk_err. The send() above then fails with EPIPE, as it does on a plain
TCP socket.

Fixes: b341ca51d267 ("tls: Fix tls_sw_sendmsg error handling")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested on net: with this patch, the send() above and a send() after a
reset fail with EPIPE, and a send() on a TCP_REPAIR socket fails with
EINVAL, as they do on a plain TCP socket. The tls selftests pass.

Not addressed here: a caller that ignores the error and sends again
still gets one more record queued per send(), because
sk_stream_error() clears sk_err for EPIPE. Before commit b341ca51d267
the EBADMSG stayed set and later sends failed early.

 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 226e0f176fdc..f3e496fa47ae 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -711,7 +711,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	int err;
 
 	err = tls_push_record(sk, flags, record_type);
-	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
+	if (err && err != -EINPROGRESS && sk->sk_err) {
 		*copied -= sk_msg_free(sk, msg);
 		tls_free_open_rec(sk);
 		err = -sk->sk_err;

base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.53.0

