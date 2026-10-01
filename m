Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89D47C113
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879023; cv=none; b=fAkeArB/xQeYCpVtKxwrnYTfR0B5oISMlWDOUTTny5uRLkehDF/dipqteeTHXkHc6BIYxJTsR4ET+svoYjBxsjax18ywehZ4wOnwZD2e94E5muW3fLZyxkY6OPVwKGaVS/ZzVBoyirMDgcdCuM9PhA1UrK5K9GdtzfTuJILFY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879023; c=relaxed/simple;
	bh=w+Rj3G8MeWENpGpU9bkxb/49JnYbE2AI4ESVecBl5GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbsUZ+xHzHot1GSMqQuEWMTHAbJLmNH0uzRi4UC3rCmMYZvGgc6rCwpWu4cdpOI/DMQeUis+tpToZFDe43w5AIr6T1ybXgI0YJyDRCOt0JfCQ9fJf8PdPw3u6Y+L4Y8zkrJBTFSUbq0Dg2GTxlN6kMZ0HJnM9cwNne+GhEtumm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve/tDQf0; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve/tDQf0"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347866278b6so2510080eec.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879015; x=1791483815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Dv8H1/zE/snIuNiW4tWqkCz7WUGP9hkqZg1+JIUl7I=;
        b=Ve/tDQf0UBNL9KsYUkveTknpoDpj/g8kWh2szirPPSwwN+pu3RME0j87mMzYe03xuX
         q+aSakTbfdWDjXKsKjhKAqK5pcpERbfG1wadznkf0zSsm2HF8YDMYuJCA0mJo/7AxmwZ
         LNSHiNJt/MvA6gORm+Qly0tBBLkWEdeh8cIGI2+VgGqBy7GW1zy7H62XQVgY66ce3Iff
         Si4MDladWyhkXM/99Br7j2EWm/grKsNf/JeDtaVlAmtogV0Axw0c75NuePF2lNwBbr7T
         h+bLXHxTShxCsxRbaYA5NJsphXLu2HxXeOQUitrJVgv9De1MOUj4wfxnafXnOfIAsNRA
         cSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879015; x=1791483815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Dv8H1/zE/snIuNiW4tWqkCz7WUGP9hkqZg1+JIUl7I=;
        b=pWqBEF/aK007dlJuZSEiEMzKQwJRzrcH0nYuQM75N3nXcuEt4ry3PoGxluNwy0b3P3
         1ERgxvC7fwyIf6y0SPHcgeJ95NAzeDOm8mcETWRqXic9GUjhF+ssnObVUPgkGBnnJuV4
         hgW0brLBCZUMkCxYj3UlmvO70gmdOmX8bowbTrKacRlelRWMpJw9u9nhrTYmYWeaHxLh
         dVHaEvBVAJDiZR4XwX/Rv5GKu3+fxmMdRpIW768HuYLpJvzQOR7hntW4I65ry8M/gFr9
         OI9irm12xL6hLKbs+u0MXqAb+efEvZzvrJjEIQNbr/cQrJo66gE9sz/YShssMpinIXwT
         xqmg==
X-Gm-Message-State: AFq9FYKj06v9YAsC2FOSVq7hxQVWlCpgey4foyZOC7xyQsfEsyPrIz9B
	8sdfi1hSYeri9gnbpwfEgKIsB/uZqJP/5xNjFW7kUnlaLCym01p/eeSZ
X-Gm-Gg: AYBFou2Gbp4+7kofrcWpCtpXxoIk7C7n8dL5wD4XJISpTYnswzVxADuhUnIm9N98Wt/
	EslNItyNlbEiqTLzvVR/TFKkq9D6WSaH4L1i9CfkiT1ia/ZgAyNk+AZb71Qma0ve98iBcmo6NLj
	ihnIutsoOPNYXyFnEPOuvUSEYfR8VdAYpHtAj6SUddMvcJs8++z98+OW6bnK3+vFsDng1KtoL3f
	dzAgAAigaDvCsOsD4aRRf54BjkfFj7UZREljQtIBKm5CIk9FNUPHhgdYPDy0mhHXYq7QvWW42eD
	J5qj8m6PsT7k5Xq9Un2+qkBhZ6lYQCTvIjtcCYCfu2PCiuo+OnLNRb1Pf4Xmq8NCqJuvzximShr
	fPKpcwK9j2ksIHcSEQd8XhZSqznD89lhxG9EQs+/CH0PN2D0Ly6SV65ZKAT63jnB6kymyl/RIRU
	fXLNHFT397pt35UGzy8iQBQX/una42NszuLHgH4M3H6T7zgwdSC3zbk+dKcyJaMyT7cCCw/yOED
	aQ6Y/IC6OfEaAWPDRV8/YpszLP69auy
X-Received: by 2002:a05:693c:62db:b0:33e:a173:4aab with SMTP id 5a478bee46e88-34f150ab94emr73498eec.14.1790879014427;
        Thu, 01 Oct 2026 11:23:34 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm189671eec.5.2026.10.01.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:23:33 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+2cf741c3005abc20@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2 0/2] net: team: fix transmit skb ownership
Date: Fri,  2 Oct 2026 02:23:24 +0800
Message-ID: <20261001182326.572045-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926090039.1714460-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue override path can pass an skb to a lower device, see that
dev_queue_xmit() returned a drop, and then reuse the consumed skb. Fix
the handoff decision separately from the transmit result.

An AI-generated review of v1 forwarded by Jakub identified a separate
broadcast-mode leak: bc_transmit() returns without consuming the skb
when no port is txable. Fix that in the second patch.

v1: https://lore.kernel.org/r/20260926090039.1714460-1-bestswngs@gmail.com

Changes since v1:
- Use list_first_or_null_rcu() in the queue override helper, as Hangbin
  suggested, since only one override port can receive the skb.
- Add a separate broadcast-mode fix for the no-port skb leak raised in
  the AI-generated review forwarded by Jakub.

Weiming Shi (2):
  net: team: stop reusing skb after queue override
  net: team: free skb when broadcast has no txable port

 drivers/net/team/team_core.c           | 16 ++++++++--------
 drivers/net/team/team_mode_broadcast.c |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.55.0
