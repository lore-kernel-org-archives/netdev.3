Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55125B090
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778881; cv=none; b=bJ6eLt1uM8QrXijpaG8WJh6F34jmyteInimkrXMT+ANgynlqMoXMQUYx8MIrDUxVJYoTrEDwMmXmlRrR0e4PH/S+vRfiFbIAdzII6QtOKLvqyN3u58jYNOxCvK8zVbUoCbeBiI0No6DEsNbTpcF4Oz22Msa/y0RfAvtYDes6A4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778881; c=relaxed/simple;
	bh=JDcC+8W0NtqfX3d4KPNUDQRwNaX6Mqnss9MR+9yhyOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVeB4SVLrY/khKKa+WaJ9SI4QtRDN+EpDBxvssB/aZVc7itDeuJTcgFSl0lVlW0wwf084G3m27vZRZdzhLYcBZ1XUniSc1rSBG4s7w80QPUcqDs+MhO9uYZMdwUGJcrD4M9JghXGY9PNIj0HIEr6Pw/5k6T8lLkdO0rkGi87y8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caIfamMQ; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caIfamMQ"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4aac9321so1237726d50.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778874; x=1790383674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5aq8pQAxs7MtbClpVxcykWFkUL0M+wj6iXKoEEqX8k=;
        b=caIfamMQgI7yILHBZwecB2nbHuookWRf7FcfI0RKTyLQot+ULbkfVKtJ1ao3swLrlD
         vUf5EVvHgUm16jwm8BTf5aUE0Bz622tXPwhCZiAYffX0+iqwllq+lZ7Wxozh4zyhalYj
         vjnIPDffcfTi2LU2SoRX4Xbpki8CchV3OdmGvOszyx1TasQ8uPNZ41FS740AMnwfccVh
         hnXt9rQ2Az0a08TNAKcziEe4knwS+MNAHoy8gsxWrt8gFvMs1iAUVPwiJx+zOOizioX4
         rrqEIkEewzp4l0tkIkae4DF30GxE9fq1EliFuaXERJay0bVeLoojg8zB+hl8hgm5rlJn
         1wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778874; x=1790383674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5aq8pQAxs7MtbClpVxcykWFkUL0M+wj6iXKoEEqX8k=;
        b=Hqfn/nmkW8mWHLa4rmCbIcapm9ra+OqLzmsQffC8aEvwUdAugO8b0uOpr+c9uUW9QR
         fo5SkpfDg8QcKqyXqRqcj8Nri62ZfIkmk6kkilF16ClWLkZj9RlKvNGao5fL8ypGbpjU
         7PKu0G+SIB+75QlnmIEI6fQ5hZ3ahM6Gd7x2RZBWck6QqEVP9NwtKYlkuUJlGI2aYMJe
         m2tbm+rrJq/3sO9MuZVCE0QDV7INiCkoabOtcWr6J5bW/+J6MPuNwd/1mTnxyglPM9fg
         j6QeDc9XoIlOhZujGrygLd/8kXCuRenYQrIvrw+q5yNbsM8leOjxt8uf8Yvh43Ter/BZ
         vv9Q==
X-Gm-Message-State: AFuF++mnYx2qf0c3U6f9DFbG/MQL4lzs4C6wZT5DndrlrvMiy/q2lkDK
	s6p/mK/FJcm3Vh6pZ93E3BccTseYUYQlp/yJ5xdHzJxvUW6NG15UyFEP5oCACA==
X-Gm-Gg: AYBFou2KTFjPCpoxnIyN0HqPbI6ppLlZLzKqbU5QoCFOJRT1yCsBjbz40i2ADpns93l
	s7t4EfGmGbrC45mBPERPVKV9LJGZCVhYksLKmOXwE7Fbv9D3QpzTpEz8EEKZgJC8ipy7eAHNMWx
	Zji9BIxGn5qCWp7MGMee3JWBYP2SSstA7mXaUq3WxY1GLpBXz5TWPE8b715gzRzrWIUihEy558C
	qbfNCfut0VIqKcqlu8BLr6vrKCzgWcFT6GQNbZcFEP+z9R4MyVZvUmQFZ4rNRHZ/13AYlq5ExKu
	Ita1IAcOe8HplYc37x19aTZVvooY6G0/YD5dQFXEHF4BF6WcWLQ0jPv+EF5zhnRLE8Zu3FaArWl
	kSIrOLsDqoQefR5Lseb1DGNaSBVOmTVRWvOvXNgVCWmSQd576iihXtAvpwEQg35VulQa869DKQN
	lkVWOiEUsudBpvB49vus2MgfVZgMed95qzCTEDMZ8sJ/uAi3H62kPaP/ylSYKLYgk/AY33pInKh
	lcRUYkdqYOLwME95UEgSYrZr/zUotH3ptebtR4BzN/h+Vu2xP3dKMyeyHRUPLVCdsNyX7L9E/U=
X-Received: by 2002:a05:690c:6081:b0:86f:c1db:14c7 with SMTP id 00721157ae682-897308fd24dmr15009437b3.7.1789778873718;
        Fri, 18 Sep 2026 17:47:53 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a478ff1fbsm4999977b3.31.2026.09.18.17.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:47:52 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2 0/2] packet: fix PACKET_TX_RING data corruption on skb_orphan
Date: Fri, 18 Sep 2026 20:47:27 -0400
Message-ID: <20260919004748.1463985-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

When transmitting packets via PACKET_TX_RING, tpacket_snd links user
ring buffer pages as skb frags and releases the slot on skb->destructor
(tpacket_destruct_skb).

skb_orphan() invokes the destructor while the skb is still alive.
This marks the slot as TP_STATUS_AVAILABLE prematurely, allowing
userspace to overwrite the slot and causing data corruption.

This series fixes the issue by switching PACKET_TX_RING to standard
ubuf_info zerocopy completion, ensuring ring slots are released only
after all payload references are freed or copied.

Virtio-net needs a separate solution, because deferring the release
can cause deadlock in its !use_napi mode.

- Patch 1 addresses the virtio-net special case.
- Patch 2 converts tpacket_snd to standard ubuf_info completion

Patch 1 must be applied, and backported, before patch 2. Both carry
the same Fixes tag for that reason.

v1: https://lore.kernel.org/netdev/20260914214229.1674102-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (2):
  virtio_net: copy zerocopy frags in start_xmit without NAPI
  packet: use ubuf_info completion for TX_RING packets

 drivers/net/virtio_net.c |   9 ++++
 include/linux/skbuff.h   |  19 +-------
 net/packet/af_packet.c   | 102 ++++++++++++++++++++++++---------------
 3 files changed, 74 insertions(+), 56 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

