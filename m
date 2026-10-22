Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685397;
	b=L1hMV1ZwCJrytk9Ft3VKrH3sYZc9gSV93sNuXgBj0Fu1Ixlw663Tf5XayBBgXCeKstD+
	 9BOfyV1R9lug0tEz3SGaA1B/0gpr8ijftuztXo9Q830u4BTTiq+HFeBGZqRtmbgr8sRvO
	 wv2wMZnQ/P/S3mM5yQYXTC1dem5918zdzo6WjB9o0aU/IiYJZwmyBRqa1oWIgVnWi6287
	 LrqoWNKlWx1OvSEQvcs776RxH0sOSQEkkhIGWFlCK9qWcWSUQxvKAaIAqSV0iMtchvAVL
	 XlawVj+qyVT1Aao9wVpx291QBpBLsmEx1WSJZSAIB47ZLTua4S2mWyUQ8yJB4KOLNag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TIhLtdd73+BRgQ3n33WlKdoMKFDFngH6r5DDdY1gqoc=;
	b=I6Kpl+4ltmjUmiUjJNfwGaLXB5wzZum/1Mw1amTEf6W/ksGqyC7RHzf2eCqb5tXF6L7K
	 ayxjujjjq2Bpk3CHPFIhtKeRXUJj/8cIZdB/Sk5GbxcaBEkAFm+j3Tc8YqrwWloIZrr5H
	 jzEmxliXs9NN9spHS/wh+oN4S5Map8FGhC/MdUc1shI4nOnatQW0ZsFOengec8tvx7bRY
	 4RI+sZcO71xG5AaJgQNcneT1Ef6rAySWjL661SW27T9p0uDhUfhJTnoSmKmZnZl0sTCgl
	 VyfBiqAQvlSSQpYlOvh+OzLRHnetiw89OlUrVQN/DcxlNsbyjceUd3wrWxbUhYT/PNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fws4Q0b8;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B9606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fws4Q0b8
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2269248c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685396; x=1793290196; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIhLtdd73+BRgQ3n33WlKdoMKFDFngH6r5DDdY1gqoc=;
        b=fws4Q0b8g9s5I5mCl9U/tX8R77A68BHnAZRwCmIFqYo8FJFAlZJgB5RBbV6TDRHKP9
         Hb05EBprBImY90nAxjoS9BZQ2dmRFcUAUWsA2emBapps0UMu5dQYoYUf2xkWdPvH3vuQ
         eb34ASKJRnOaL6BDuTe1j36T2nqTwTkvvirpK78w0a7P+d7t6QyaPtIIGif0dOn2SR6j
         SuHscAOcrhRXEgwl7K27cJKugD/lA7COSw3Tsf1ZRWShHGRXHwR84ELZq9V1MAWU5NSx
         1anzO1aOt6MljYMRBBwDM0TzafcFl6YhLabVWSSA4RhrX8KztVrUjnWOvpC6SyJhV4wF
         kP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685396; x=1793290196;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIhLtdd73+BRgQ3n33WlKdoMKFDFngH6r5DDdY1gqoc=;
        b=Vh3wJeNRdE6eQo6HSuZwlYxTaFIJHy7In0QYQeVjH950Em0AjTHHye/7GwkRw3Q6JS
         kBTXePXQBIX7zQHQptKc0Bxomjaj3jjtqMIDjwmEr6TQVQFYGg4sWacDfxL0isTMj0FS
         Hf83kMOMuFS0591clq1w5gk4jFWJ+yJ7qVfxm1tZSrWZrT5F4zjeLcnf8ipmRG1FDRax
         6UCm9H+apKnYtD9kFeEW4NEKPkHN9DZnZ4jkQjeaafok52s0f3AEhnB1FJIP5hwxurxT
         4WtHeNe3OVQTEmX3F2y4V4UqjCYy1MywCilJX5FJUBEbPj/EUJ8dZV/H0YV/mh9Alp4G
         Ydgw==
X-Forwarded-Encrypted: i=1; AKwUvBz4X/tgKCOL3T3jzqxGmmi1N5XIyP51mp0+V8lzzMThDrhWiPsoLrPIrlzNCvszq75E6W5wruY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaz4ymIx5sPLvCum5LDrR4fpASNaL9oWc2IMLagdJ+J6Wh2vzI
	sO8VQ4DJ+3CKfh7La2uKB65YOsugGpyZrU7IAmpk5FGyEoXINLJGSin8fkFfkK72rh8=
X-Gm-Gg: AYBFou27LigSJuvkkcoeB/YrdS7oHVbnDtlAMDEP/r6iBRyN4u5sI2iyhb08I7T3rPC
	+AJQ0+/jSxjY43hEn0sEfsQ5KdAl1UuARA1L6LeK6eT1u8ISj0MZbX5oqxangVjVtqs3KTFvUoH
	nt1/KnTlcv6fd0wNuJjU9A5SxaCh9DEOyv9iLN17iR0vLbxR9YSdoR5+Wcgplo81ISd3i6o3ChX
	uPzE+DldHgJniOvp5Y8pdp+TKkKW2EfRxaK0tGmtXY/LuecsxKUgugeoGm2zNDuO+k+MTP0Cthe
	r4YslF+M7MUpCESFU8GBVkV2VqKanz4fq8IcHWoaBNVI2HUzt7Ito9+d02+RjoXWAjhTTaM9Q8o
	/Oulc5kZhEIe3JchW4DW9fajlsLp/kuESrCNfTF6otTbZCse4WD1C5bm2snE1bLQmz+wKI7mT4K
	HgTqWR4e1GMwGufNKEKlums7eUpz5s5tMj0rgyZiFExrZBodEGQdB5VpM8UosDGrWqPHiW9PZ5f
	NSw20TDrvsH5Bi+lIHjLbBvVNn1Tch2+Z3Mhx5SuKb/coePUgRG4W2Pz06LmdeknZIup8+Hy42g
	LeWc
X-Received: by 2002:a05:7022:6b96:b0:188:ecb4:489 with SMTP id a92af1059eb24-190a73812b2mr10005892c88.34.1792685395834;
        Thu, 22 Oct 2026 09:09:55 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:09:55 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Petar Penkov <peterpenkov96@gmail.com>
Subject:
 [PATCH net] net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()
Date: Thu, 22 Oct 2026 08:26:48 -0700
Message-ID: <179268538303.70821.16548460883330758972@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

With IFF_NAPI_FRAGS, tun_get_user() takes tfile->napi_mutex, gets the
skb from napi_get_frags() and copies the user data into it before it
enters the RCU read-side section around napi_gro_frags().

tun_detach_all() waits with synchronize_net() and then calls
tun_napi_del() without napi_mutex.  netif_napi_del() frees napi->skb
through napi_free_frags().  A writer that is still copying has not yet
entered its RCU section, so synchronize_net() does not wait for it, and
deleting the device frees the skb while the writer is using it:

  BUG: KASAN: slab-use-after-free in skb_copy_datagram_from_iter+0x175/0x720
  Read of size 8 at addr ffff888077def990 by task br029-poc/9406
  Call Trace:
   skb_copy_datagram_from_iter+0x175/0x720
   tun_get_user+0xb42/0x3d00
   tun_chr_write_iter+0x113/0x200
  ...
  Freed by task 9405:
   kmem_cache_free+0x184/0x670
   __netif_napi_del_locked+0x2bb/0x3c0
   tun_net_uninit+0x566/0xa70
   unregister_netdevice_many_notify+0x1a26/0x2090
   rtnl_dellink+0x514/0x710

__tun_detach() also calls tun_napi_del() without the mutex, but only
from tun_chr_close(), when no write on that file can be in flight.

Take napi_mutex around tun_napi_del() in tun_detach_all() for both
attached and disabled queues.

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7cca1a6f72ff..850318482697 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -688,14 +688,18 @@ static void tun_detach_all(struct net_device *dev)
 	synchronize_net();
 	for (i = 0; i < n; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
+		mutex_lock(&tfile->napi_mutex);
 		tun_napi_del(tfile);
+		mutex_unlock(&tfile->napi_mutex);
 		/* Drop read queue */
 		tun_queue_purge(tfile);
 		xdp_rxq_info_unreg(&tfile->xdp_rxq);
 		sock_put(&tfile->sk);
 	}
 	list_for_each_entry_safe(tfile, tmp, &tun->disabled, next) {
+		mutex_lock(&tfile->napi_mutex);
 		tun_napi_del(tfile);
+		mutex_unlock(&tfile->napi_mutex);
 		tun_enable_queue(tfile);
 		tun_queue_purge(tfile);
 		xdp_rxq_info_unreg(&tfile->xdp_rxq);

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

