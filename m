Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BD37E5D2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516337; cv=none; b=AkBtWlW7Uy5HjhmqZ3AuXf/c5bl4P49ecJqSVTZQNojhaymBeJjuL8njBqZV4KT/XKT+RqPMbk6C845biqz/P4ZjrBTZhIqoy1HxMYg8IE/9Q19b+LGEeWn5RHAgfNSVjRyVBjheUrvmpQYbcONd5Yn/kjOd+mC7GNfgeMqrhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516337; c=relaxed/simple;
	bh=XAO8a0f6lkr/LOkHNd81baGqXg+G2u2xKghhfh0jkl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI8GH/WGBjP/hRxL0jovudU6K5hC33f97JwV60tV3e7X1ChSiiUs4D4+U4cq1Ee0beMSMUhz1QHghypX61mhlrDzPOPLqWsLV9FQhF45GchenKA5nGQsi2nZOzKPvJbhnuS6VtZtilJYEgASGSlkBeEeH1ld+maqPuiUED5FegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIxbKrJX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIxbKrJX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e4f0d7d77so517132385a.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 20:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791516326; x=1792121126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAO8a0f6lkr/LOkHNd81baGqXg+G2u2xKghhfh0jkl8=;
        b=rIxbKrJXxtFHBN6qY5V7vcSq7aTz1APFg7lxfqzpF/XeDybxl683IMRmM0tkPD8pVp
         Ne62BAzMr4yS3Gjb0xtqNc6fqHYumbUshUJUiQg9qloKeLoO8PMozMsqLIOcnzT+acGf
         xcSdkwTkzJ5BOrdcC1+eyWPsY66mJ9dbHLrW4x8eGuv55YxBNxJ11sAbf+sfDPvQ+ZrP
         1ZM3N+HtCOua8g8f0wkaJxFC5MPZmUPu22xwZFSNmDjz+Cp8Udg20a2Wd6Ooa3zOJV1J
         EAeb9qLbf30drHF7qSif2GPrkOlwjUegZiHfFS5qc/axontEsbx1vZ731933A1+SsCYZ
         DE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791516326; x=1792121126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAO8a0f6lkr/LOkHNd81baGqXg+G2u2xKghhfh0jkl8=;
        b=hlauUcrvgwQa4OjCs6E1banJnV+OADOwBWnUzAGbUrNtXhJQxBL4UNwPculCW8Dm1e
         CsZgkb72qpPnZTAb8nDUgstuZJQLaJaCPioLA9+71XaNvcp/o6q1LfZH39h61hLV6QAP
         pM4DGN5DBVgvecNDpgRyEZY0eS8Q2yLv9HjYdX7QjMaRzsLLvbGGmifRJrgvifOrjXsI
         IEYZePMFMNRxl2it+Z0meP9OjEe/9KecAAIxvMHV9VUXP/IxKl2R8af2PjSufKX18WvN
         Kbs4JR12daShlMG85VR96qArt6/0b7dc6q+7ITQDfsqSk4Q6WAe0PHi6gLX+3itvqp9A
         /myg==
X-Gm-Message-State: AFuF++mLzAKYMbLQs9TfwE0r47/8S+Q/uW4ock4qv4sspz7irPWMHhJb
	KY8v+zgv4nFnESbC5kennGzQ5DWlkdnWPjpazeA80/YJnwvHwydJzKb2MAcUFIOy
X-Gm-Gg: AYBFou066qHIrtPdiaS1nr4N7DuN800D9TcqLZ/p8lm9WRaT2gM82Bd9VE+72xN+ZtH
	5L9TotinR/UX/usvh/029FS6xzriGXQBYsY+6qOJpfyv0/w7Q8vwo1ffgvJ9S0j/wkg7qgHjdy9
	7Up+NLAgnMFxKDHjd9g+cRTEGCFkdEw98M24SoEDxep/NNsVO8B4rodMhP0VV7EesnVdLnSj1d2
	XqJF8LOI1oidUJEAiLsUJWDKNPPJNLdiTFP0sNkt1zR4iITbPdRL8lCVv84+J6wAbI4uDBlzzPB
	nkFdEzUpTntYBmTvNa8whMVZSGhJOUgN6WLIO+KQu5Hepr7B4XwVRApB1Zeyl9USTKbvTNQXzQ8
	U6GtEyLM3cruBymGJmTTojGCYZesDr8mNQMxkIuZtosok1iSkILLP5kxNjtS2Q0vbcf61qGDpVQ
	A40diLQermz5hb7w2JeiayJ/3XAIdr29W3zhTTo7PS+yoVZHa4ufLs8vvIdNRmtGJ4
X-Received: by 2002:a05:620a:27c9:b0:93b:d7a4:9d4b with SMTP id af79cd13be357-93ebe9d08e6mr48637885a.30.1791516326339;
        Thu, 08 Oct 2026 20:25:26 -0700 (PDT)
Received: from houminxi ([61.170.182.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986d018sm88474385a.23.2026.10.08.20.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:25:25 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 1/2] netlink: specs: add ovs_flow del and set operations
Date: Thu,  8 Oct 2026 23:25:19 -0400
Message-ID: <20261009032520.1758340-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179146490651.434549.2629505929025835263@kernel.org>
References: <20261006130533.1620706-1-houminxi@gmail.com> <20261006130533.1620706-2-houminxi@gmail.com> <179146490651.434549.2629505929025835263@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Oct 2026, netdev-bot+sashiko@kernel.org wrote:
> [Medium] Should probe be declared as type: flag in flow-attrs?

Yes. The kernel policy marks both probe and clear as NLA_FLAG, and clear
was already a flag in the spec. probe stayed binary only because no
request listed it, so nothing exercised the mismatch. v2 makes it a flag.

> [Low] Should probe be listed on del as well? ovs_flow_cmd_del() reads it.

Yes, and v2 adds it. ovs_flow_cmd_del() reads OVS_FLOW_ATTR_PROBE to
decide whether to log the error. set listed it and del did not.

> [Low] Is the set doc complete? Replacing actions needs a key even
> when a ufid is present.

The doc was wrong. ovs_nla_init_match_and_action() returns -EINVAL for
actions with no key, whether or not a ufid is there. A ufid alone is
enough for a stats or clear update. v2 says so.

> [Low] Neither del nor set describes a reply or a notification.

Both handlers build a message and send it with ovs_notify(), and
ovs_must_notify() returns true when the request sets NLM_F_ECHO or
the multicast group has a listener. A client that wants the message
subscribes to the group.

A do() call does not get those attributes back. I checked on a live
kernel: new, set and del all return an ack, and only get returns the
flow attributes. The existing new op and the datapath and vport specs
describe the same thing the same way, which the review also notes.

Listing a reply would tell a generated client that do() returns
attributes it never receives. I left it off.
