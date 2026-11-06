Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968769;
	b=LFALHTs6k97lwp2aQIhFWdsM+2if/DhmWf155N+4kMz7dVAOUtNXvobnb0nu4Qzx+OVJ
	 uBD1cchJma8s4f+x24jcT9vuopI1M4SWYfuqvTBgTXjg6tHawvYv/QKHac4sbhCMInX6l
	 F3rsVmoGMLdqAwYx1CvYc9NdKLB6FTKdOG88IqBAcfFSnx766naFWIG+gqTVKt76YcVAf
	 3Q24vGc0Cb524TM+GFm3DzdJmrSdi/faAEGQBbEGhpkAr2GqeJgNiubl04XNs6cxLqwZQ
	 s/pcoz756BU+OY1+3qGR8DQr9hm3S+36EHlgE4Oea4hjFNd7sv9pAV8mcx6+DFPfL7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
	b=fnpdXWv0s7K/aNcT45c+RIhjxnEJb+XoNjoSmV8uNyiZyO7wxcxQeopHFv2qCwQDCgBd
	 YjfFJ53YB2oGRLBaw+0vGjiJZIF1M+x/EjlkDQtYNhA/c2+MnYyEnXWb8M3pZcWxGPxfh
	 Rr2napzdJaikfJ/7ph8tQq1nOVGr+36eLJ8dArzV4mtkK/kdzjV44FjrWWsVbGZbPyUwV
	 byR/SbOZs1asugD1YvuPiUIe2EhvO2BQvbgpkGVoBbyLpGGyNd1mBacSlznMxteWhefe1
	 Vpcr4/bwLbmB1k3oD69373WZY2rXqHGP0+84zMEhLS5Q7j6HiG0RzgMWLa6ZJ5wDnVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVGE5zOO;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8C606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA8C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVGE5zOO
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so5976875e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968767; x=1794573567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
        b=JVGE5zOOaEbByQQGxTsCgkBcDpIMcDkVsz3ghCKe7umPhL/lyJaKBzWW1nwTf6Eb6m
         jjSJvEW40hyae6cFqUnsV4Vo5dk2Tl4gNQaK7GriRjkdT++TwgmvWYFHpTxmz7aj5f3R
         Ep82Pk+GfGvCGJ0r7mz4fwcigklpdpSq0MINTv3vxhrDLbfrYOvKwTsIdMbHB4B4h3eY
         RNN7ajH95YjGwhf1wlivpaTlYy3/pqe+QJC5hQDUAfN/uaUJLef/vrmRan5VyIWO5Ue9
         ZA9RhzjNvOB0/wvp3NEKC7Fb3Tk/qjSqBWhmobAUeGybhl5RD/P3UOWvJiFch14OyJd5
         cwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968767; x=1794573567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
        b=ah+Dp44LbkVc15+Uvs39Z0TvWjJWkMRgrbsJkW9oa8Vq3I05stRigDHcIVVfEClmMx
         23KLgvmwC0TgLfFbZTpRCevToVoqqnmbu4gl67jRpdYIoDwIuPymIrxXbGvnCVXC93LS
         Wmg8egjgui+8Rg35N0DBqNvqqXR9VaN2nlATjqZNDBLqNZ0hDEYYTmmuVw86InJqoeTG
         f59Vb810iZaybylAj6fGw6BqxnbfpTWDQjLjQgVz9xvrvCJgeET/J4TFO9ANjJqBk6GX
         VntmNrbi4CBtGpu7JEAanUWuZ6j7VYpO1nC49qRkP2H/iK9TPqlrateiU0Hp1aZ2M4dV
         rJuA==
X-Forwarded-Encrypted: i=1; AL+hErHW/RiCfuQ43f0KE0SnNQHP1HN9mpS2Nkd82Rp67dYpcWwv+oZuJrTb2v6sjfzPmEA7GRY+98o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f8nae1fcAs/SdJsI8VqmDD8oTzDc18TKFl2XRV9rQWyp42Uq6
	FzQlUVVDXFi8sO30VWpleuW6WhZ/eYRLalgWZ74IaoyNuNXnRf47ksJs
X-Gm-Gg: AYBFou1XH8ouZXWmRYzmp8KsidwCmMmETXNktoK3W38tuuM2AwHlCFs6ydrEo/2O58h
	jHOY6d1ZqcSmh4DhhI1dBp4KgQb3kL+5l5FLl56DUvGLb29kULfIfDic6N9dsCNlpccZK5RYV2c
	4wvk6cR8AfqpukxSTFnyfHDODw7TCia7TR985bGJxJOiuDdF8/aD4dgVOhl7A/wMt4nK1bPUInh
	o/If5N8p6q7sDkBTUttSgkTv5USa6LvzggTakHm64ghNaavhv0IAUnbrYF1y2wL2AQ6DJmqXxOF
	Fs/Xf0KgP4RkCG/soXiOr8NlNwTDUimRCGoEJsRroUm1ygFpc9EFe3UK5F/1HK9d8ILuEZotnES
	bIF48ETgkhjWP3JqxhEiktabRogEPgmu61HZFi2GEDfyHVQOIBNAn/2/UOxp8F7w1cmcTxKbrC3
	7U+XDqkU2OKaqkKyYWLnM5C/5Q8wzh41kqtKVXs1krt2AcrgrTskxRtZdrpgG4mIxGbbejvgJDz
	rs/NysLqJGYOSZXrvaej81XJAXAPguToC4oMzG9KBunmfQXIdIYQHU1a+W23O9QghjtrZimgJn4
	8rGoWaD2QVDNiBfk2CP2hlvMleH9sqG8j9TmzIEVXg7RucqtmsiQMr1fpLqY6gZ1HHdysVPhH5U
	MWc+ZLiP3BKEf5ScbT6mTBTr4mUMq
X-Received: by 2002:a5d:59c1:0:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-49273e5b29fmr5340663f8f.6.1793968767067;
        Fri, 06 Nov 2026 04:39:27 -0800 (PST)
Received: from andreayoga.localdomain ([151.37.255.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3776938f8f.11.2026.11.06.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:39:26 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Simon Horman <horms@kernel.org>,
	Luigi Leonardi <leonardi@redhat.com>,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_sock: Report no unread data before a channel is available
Date: Fri,  6 Nov 2026 13:39:18 +0100
Message-ID: <20261106123920.162131-1-parri.andrea@gmail.com>
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

The Hyper-V transport is assigned before the asynchronous VMBus channel
offer completes.  Its zero-initialized hvsock therefore has a NULL chan
until hvs_open_connection() associates the channel with the socket.

SIOCINQ can query the assigned transport while the socket is connecting,
or after connect() fails once the transport has been assigned.  Unlike
poll(), that path does not check stream_is_active() before calling the
transport's stream_has_data callback.  hvs_stream_has_data() then passes
the NULL channel to hvs_channel_readable_payload(), and any user in the
guest can trigger an oops:

  BUG: kernel NULL pointer dereference, address: 0000000000000178
  RIP: 0010:hvs_stream_has_data+0x23/0x120
  Call Trace:
   <TASK>
   ? vsock_ioctl+0x74/0xf0
   sock_do_ioctl+0x42/0xf0
   sock_ioctl+0x27d/0x310
   do_vfs_ioctl+0x700/0x810
   __x64_sys_ioctl+0x7d/0xf0

Return zero unread bytes when no channel is available, before accessing
the receive state or ring.  Leave the existing channel-backed receive
handling unchanged.

The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
guest with a small user-space program, available on request.  With this
patch, the program reports zero unread bytes and the kernel logs nothing.
Other vsock_test cases were not run, as most of them need a host-side
peer.

AI assistance was used to identify the issue and develop the fix.

Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
An alternative is to check stream_is_active() in vsock_do_ioctl(), as
vsock_poll() does.  That would also change SIOCINQ on VMCI sockets that
are not connected yet, from -ENOENT to 0.  I kept this fix in hv_sock to
limit it to the crash, and can send the generic check separately for
net-next.

The reproducer is a new vsock_test case.  I have not posted it, as
Documentation/process/security-bugs.rst asks for reproducers of bugs
found with AI assistance.  I can send it privately, and will post it
once this fix is merged.

 net/vmw_vsock/hyperv_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 855b15971c359..551eabe690144 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -697,6 +697,9 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 	struct hvsock *hvs = vsk->trans;
 	s64 ret;
 
+	if (!hvs->chan)
+		return 0;
+
 	if (hvs->recv_data_len > 0)
 		return hvs->recv_data_len;
 

base-commit: 475ff14ba558bb8857bca878f1d593784ccc4f0f
-- 
2.53.0

