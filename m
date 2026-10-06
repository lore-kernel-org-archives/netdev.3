Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E927456E1A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291962; cv=none; b=SYUfV5zhICp2xeAotn8qeUqc/nFDeAqR46UNhCXTYeiv++5DHA4oTyEQgpZWtiGusixnUZKAjBNx5ftpnjk7OVFd4Hpujt8OHQpclxpTRhYGLMc6FGtLmA7ua1ZGfxPJ78n0ZmRTpU2oPs7NNhx+NJCqIFH+fPGQ9FmQl4vY6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291962; c=relaxed/simple;
	bh=HvUe+woKYxTyFq5JpxUPzSBOyzzQnXTSKNRusvt4Dg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XO1UFBFyDy8uH5sbzWBid4rG+63gM2xV09FlR+xMjMq8XJtT6uMvXt0+1Ee/ewQmzWI/ZIqCwOdDjco6zhtEwqD/fCLeMegCBUXj7UhvwGjXmnMfn2+LvFqgsRbD2WOifrFNbtQK7h+WNI6iSLlN+LFEoaeXXV5OX4ViLP27iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imUlOl2r; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imUlOl2r"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53391022dc0so5313821cf.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291960; x=1791896760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyTMN8bEuKjedpV+taqvE9kUT6xuXuVZaT92D0rX1fE=;
        b=imUlOl2rJTI8VY0NSEjAo8wIDhedU6i02I6PouW32I0nO/5kEcVINWhCnh9kdgP6QN
         Sm1RGnMRA5Hp728yd2/tZF5PAJUL2TctrtuZLc51TtMzC9iaudHgqj0t6k7an2ZQRiHy
         W5qfCQs8jj6ElDzXYbL0/sQyxkCwpGbpRl2+AtdIftpH6GZPEUZ50HQyqKYeDLeZlXme
         WxjViVaf8BOWENJqeL9JGMvpx5KPM4JvIFbbFQrqRkX25iEAtbZ49rPmQ0S3KZaez/3W
         xk/uCtxzi0L1O++VkJlUvKiYvpacRCk9dilRGUCnZCyoRIki1yk19d1PaLKr9nCY0Dm8
         Cj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291960; x=1791896760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyTMN8bEuKjedpV+taqvE9kUT6xuXuVZaT92D0rX1fE=;
        b=LE/dRG32i9FCc77jY9vtnEggQkPhMaCfDn6XoTrVLSMOXIa9RkYgCKHr1JjcD5OLS1
         tP8mQqMvvYUwgbaLF38OBtszXwGwjOVcgH7TG1Y+VZ8oQ8sss1TuL0og77triphBhVKH
         MsKgTdZXun9LVHA+vw65pWn6+lbPiYQ6+Fgo+mzdJUdVPE/VcL+wBCbkUupack6MXE1V
         14R6Xdt+o6IZ5Nf7fz3SdWSz2Twrq8j6drvWJrFtFxGEv9NU7mjUzph14bA/mcp9HdKU
         RdeVEcgjhm6e9yudsDdCReC41hG6Yb3U8ETe/CgXaZUkb+uEdvJP4h2emHFqHLlEvj4h
         ThVg==
X-Gm-Message-State: AFuF++lyAaVbHtUq94659VS4UM+cZ02gTRr4Ea+aN/xhPfz7O8JqzKZj
	3hHr8GKW4Eduk70Rf4PdkC/YjVJU3S4M+pmYOHuvfBhVmv/pZkIkAPBAk7YwHbGsdX18PQ==
X-Gm-Gg: AYBFou2xkUhVuFmJgAfwFlG4YM61o9xb/sSJGE1cRDWwo6osENAJ4zgOz26Ifmyae/D
	a28LAiHm+X4m6kSMwJr26tDEE5nYGLC9hD9fb+JpOYMm+K/b7H0hZg1TuUtLCFS5YyqndUePp0Y
	BB8DviTRR7K62WvcKCZ65NpJdJXwgHdvMgVLb7jB+LYIu6jwvJwMOkQ8KGItWhjTxki1l/LVnN3
	kT990d4MkBZ/q7Rdx2vPRDDMeu9z4n/TCItw1wxYExTQy8FGN+x/4+1enBfaQh5d01l2RAXsoWW
	SmDDVvh9XGtnjO/2UCltBa55wIZL/3g8GO7r3Ch47x6cPNReYjWXyCsa+V7IFAyULNSeurZpgn3
	orZEXh9ZG9lTVbFz5hr3to/p3H/JZullCYSB8LvIkk92jWPyjX+eWZ+qZnuhY7x7tR7RcLuM94o
	dyepIu+x6VQNWZ7GHR/Slr+g1RSKJUOIgGmsNjuODZdb4IC5iBnv0F8/vY31lhXB9r1ayZWMy19
	akK
X-Received: by 2002:a05:620a:4441:b0:93b:e578:5838 with SMTP id af79cd13be357-93e8f20d003mr241476085a.12.1791291959644;
        Tue, 06 Oct 2026 06:05:59 -0700 (PDT)
Received: from houminxi ([61.170.182.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca263708sm1102596585a.31.2026.10.06.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:05:58 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/2] netlink: specs: fill in the missing ovs operations
Date: Tue,  6 Oct 2026 09:05:31 -0400
Message-ID: <20261006130533.1620706-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovs datapath, vport and flow specs describe families the kernel
has shipped for a long time, but each one stops short of the write
commands. ovs_flow has get and new only. The datapath and vport specs
have no set. Nothing in the tree generates code from these files. A YNL
client only hits the gap when it tries to send the command.

Name the missing operations and the attributes the kernel handlers
read. del and set on ovs_flow, set on ovs_datapath and ovs_vport.

The handlers take CAP_NET_ADMIN through GENL_UNS_ADMIN_PERM, and so do
the new and del commands that were already in the specs. Mark all nine
write operations uns-admin-perm. get stays open.

Two requests are rejected for reasons the attribute list cannot say.
Flow set returns -EINVAL when it carries neither a key nor a ufid.
Datapath set treats a missing user-features attribute as zero, so it
clears whatever was set before. Both are in the operation doc.

The new, del and set handlers fill a reply, but they send it with
ovs_notify() to the multicast group. The caller gets an ack, not those
attributes, so the specs do not list a reply for them. get does, and
it returns the attributes to the caller.

Checked against a live kernel: flow set and delete, a delete with no
key that flushes the data path, a datapath set of the masks cache size
that also clears user features, and a vport set of the upcall pid. A
vport set that changes the type returns -EINVAL, as the handler does.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
Minxi Hou (2):
  netlink: specs: add ovs_flow del and set operations
  netlink: specs: add ovs datapath and vport set operations

 Documentation/netlink/specs/ovs_datapath.yaml | 18 ++++++++++++
 Documentation/netlink/specs/ovs_flow.yaml     | 31 +++++++++++++++++++++
 Documentation/netlink/specs/ovs_vport.yaml    | 15 ++++++++++
 3 files changed, 64 insertions(+)

base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
-- 
2.55.0
