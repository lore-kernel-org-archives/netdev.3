Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205757;
	b=uKr2GE+YSyhJvph0U3NZqIRcpCiGvef3G+ZKxdcGHprSQn5QBeOd8/lRrZiecLiC+r0e
	 mQI5BDjJCSJy0s0qJNkZsmBOEzF9iKv2FCldT2lkLcww0x+RK+sAyHCJ7p7+lpWXNr/vt
	 mcPMb4+McSxTiOX1NCo7bI0JynXjHEuObbpydmmhKE9m6Ss15MJIc0XYeHP4esNPcVYaH
	 vdJ1DV+U8H0fT3PrvixOpb/x5PLxljnco71MeLe6u4W6dDj36Fc9nq8fmZmXVWuxkc5kG
	 g/4f8dgK9DRomELG9tVE1kWga3Mw5SAaebooVmeMGryyGRpF2rohRYxlxyIonkxYBIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=KXa6hdR4Flw9fixypQPPxPpj8724VJPyxYSa3LOTZ0s=;
	b=CqV2wuM1d2wXXaRbomCtcFmVPoeJT5GMCX0gjsk4WiBrDs7d0oc9LSZ1Rdtww5uEAi+V
	 OAxcqJfjUNeg5XqEzR8o33znvDwJral+1WjVBFsaNlY701fgsWFumXfJew8a17aQ4Mco5
	 AMp0gKUd4oTgzN7R7O0qqmgQERJlNHxAFO0n2is75b38//Rdfv8LsvJ4N9J4DwCS9+Qs7
	 cYn+0AHcg/jScfEuDSdHJNgYFGY6zogFyLlxk9MbsiCptZQeXJ0tJXywe/bJvmvWntojh
	 1OVcUJgu5nlmQcnQ0xD0sx0WxAI++b3LwYrU7HMD6wFTH1gnvCvzODaE9yqFdcFjZTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0UWUwVY/";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FB606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 06:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UWUwVY/
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso251332a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794205756; x=1794810556; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXa6hdR4Flw9fixypQPPxPpj8724VJPyxYSa3LOTZ0s=;
        b=0UWUwVY/5G2gAwW+AVbfPoh6eG1mO/TSakDZb7kfA55Mf7HcvonGC/gcYe45C2sOxC
         SRl0vl+hY7cvgpmzX8lMoAwdnmx9Uv1SYo0msOeskU/wQgysaobY0WtzOJffyqyZyMEu
         lrrVBD7ranWbyXkCBDwklG0L/SfyUrE9fcNbw2sHCeqBuOQzC+hAsN4gcvZI7OX72fl/
         rM6qKBx0xlrDzX0RJxB29PGlyT/B1HpuJPsKrpe3uR+GM+2HncYUrT0DfOAN/bIPGMY8
         D2FlsJOFmTmX2NtppPtmLTL903FrSWMBFN/4lVHFsJGxNSOHlWTy98j/8qiWLyNCi/Ex
         YJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794205756; x=1794810556;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXa6hdR4Flw9fixypQPPxPpj8724VJPyxYSa3LOTZ0s=;
        b=HAYk5lKUHk/USV+xtVk7s6VHhmudz1iHLCqvkTryh9oKCfYY84lOApxcaJT8SEooVV
         euarDfuq+U055FCuR4M5bYqodFruZcea7XcfPOBgFacttjQDuR5ezg/cdd3XEHFXe4eq
         MOKlCv23wYGz8zffdyVoD1CCnTRbo74YtsUlecXHD3nhjKOAjfxGB7ESJgqXwqnKoU01
         eTR7stWZ2yI67jg0T4h2NZUVa9e3CHZ/7+8yxwqJ22AIncOgkVzlJlPiPv/wDNbFlHZU
         5CDquzgr+i7y0Syp16j3cbJim2F8FEFwJXSEYdatENHltxwt5mPPoBCi2kyMkjZ8iz0m
         Ujng==
X-Gm-Message-State: APuU4Z8tfpIaWDBcmQ6d0BGi+loabSG7oDXu2x4vm7fN8OrwnmnKUt8o
	UkkJwh5uxSZ0qlGPF0N9sD1FoHVbPB1Qm1V8dpUgjWelqmM3mz6jRByk
X-Gm-Gg: AYBFou1sGsyLAVU5C0C3EhodxTiONL7MnquoFAsQGrXflNBkbZ389SY1RIVonh4RBEI
	i9HMcPDM6fEC0n0OYOGLPIDh1z2BmqFTjDSYYUPBKKiSlz72yOqBo1e9l/nkWf1aJlyPK+f4U2p
	xtWNf/sxih+Xyl+aHvCLUapwjnX4XHLiwl/l6HpWrzYkYYULWL/oFXCU6ADIjIqk/SZTNGRPUbX
	OyHpJQ5Jwzj/dlMJcpJX4uB0dwbjtTM7mpwCOUhBUdh8YpJjruFdR5MpLEiMD0LiLaVZ5Md6F31
	8Ob5KFhyfBYIeQoIVVwJMJUTw+DDGwdtAq9V8HXiNOM9mnVsK4t9mQXfEmZtddf4lf1qmwPLhCT
	+qbPMP4VbtYQfwzf9VCqinrIxrKxlBsr1ymDp7gVPCNn/M2UCimidkUJ6I4SszuY070cRHP07b4
	rmsNJ7Mv4D+Vrm9nKpsjvWrqMgP7/8QF1lUj13OqFRjJy2BJ5tdbmDt8RV+Ds6sN82A5AlG5nn1
	+XZSRSyvyKC9ORU+FH9gCRcSi/4+oQH9hzEgjG3wjhooMkTGdzP6lrnaO8tuZJhlAEG8EBmFWCf
	DfhMVEdSgOQJIpXfj6tBdR+nG0ATAC2Kw3DFF15ZNYfhneg=
X-Received: by 2002:a17:90b:5205:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3b12d508483mr1765326a91.28.1794205755816;
        Sun, 08 Nov 2026 22:29:15 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d3310sm9538425a91.15.2026.11.08.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:29:14 -0800 (PST)
Date: Mon, 9 Nov 2026 15:29:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] tcp: fix request_sock use-after-free during Fast Open
 accept()
Message-ID: <avFoNgJENLYu4t7X@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
made inet_csk_accept() check tfo_listener before taking fastopenq.lock
to avoid taking the lock for connections that did not use Fast Open.

reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
then reads req->sk. If inet_csk_accept() concurrently observes
tfo_listener after it has been cleared, it skips fastopenq.lock and
drops the last reference to the request_sock. This can free the
request_sock while reqsk_fastopen_remove() is still using it.

If the freed memory is reused for a new request_sock with req->sk ==
NULL, the reset path in reqsk_fastopen_remove() can append the new
request_sock to the original listener's list of requests that caused an
RST. After the new request_sock is freed, the next append writes through
the stale rskq_rst_tail into freed memory.

KASAN reported the following use-after-free when writing
fastopenq->rskq_rst_tail->dl_next = req:

  BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
  Write of size 8 at addr ffff888108230688 by task swapper/5/0
  ...
  Call Trace:
   <IRQ>
   ...
   reqsk_fastopen_remove+0x142/0x210
   tcp_check_req+0x96f/0xdd0
   ...
   tcp_rcv_state_process+0x19c/0x26b0
   ...
   tcp_v4_do_rcv+0x16e/0x490
   tcp_v4_rcv+0x14a0/0x1af0
   ...
   ip_protocol_deliver_rcu+0x39/0x1e0
   ip_local_deliver_finish+0x124/0x1e0
   ip_local_deliver+0xfb/0x1e0
   ...
   </IRQ>

To widen the race windows, mdelay(5) was added after newsk = req->sk,
mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
reproduced with this kernel.

For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
tfo_listener, which reqsk_fastopen_remove() clears.

syn_fastopen_child is a field of the Fast Open child TCP socket
referenced by newsk, not of the request_sock. It is set before the child
socket is added to the accept queue. The paths that call
reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
this field.

inet_csk_accept() uses this field to take fastopenq.lock only for Fast
Open child sockets and rechecks tfo_listener while holding the lock.
Connections that did not use Fast Open continue to avoid the lock.

Other bitfields sharing the same byte can be modified concurrently, so
annotate the lockless read of syn_fastopen_child with data_race().

Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec438773..e5e7b844fed44 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -683,7 +683,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	newsk = req->sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP &&
-	    tcp_rsk(req)->tfo_listener) {
+	    /* Stable while reqsk removal can race; adjacent bitfields may change. */
+	    data_race(!!tcp_sk(newsk)->syn_fastopen_child)) {
 		spin_lock_bh(&queue->fastopenq.lock);
 		if (tcp_rsk(req)->tfo_listener) {
 			/* We are still waiting for the final ACK from 3WHS
-- 
2.43.0

