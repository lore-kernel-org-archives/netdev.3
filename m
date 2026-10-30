Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793353911;
	b=S1gFL+S8AAbXMwNHeVVg8oMlw1Qfdb5AeFEZ45SSeEMiSX/Tt4aqWT2P24vo73pb8ptn
	 LQ1R1GTERlGnE6DjCvRJBql7n/hAsgNeT/a8Esl+ntcr+FkQQ3b7TthrLnZ9kVPt8EB7M
	 fVeMPQzk4k+vMl+lwbJs2RzKII7l0QgyDilE+lrZmCnTIG1EAgB0GwA9XkVlKFuRKnyIi
	 9mo5f+SKzn1IvrUxvf64+kMaFdC02DajvKX8KprvfEwzemn0YzpZjOaVlJYOHdpzq17i1
	 yPeegDgnktI4uE9L3U76riOcy8182PaaidcjQEIb0/1HNtcRV5EnVimmWdssghB1nFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353911;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=frkiuxk1Rd/ojAV2wzD+GKDvqPPCD0QvXjwcP143p90=;
	b=Us63nV1Pj9ew0X2MgqEwBhWgYyk4yatrh+pfWTU7khKvZ4z1hRqolL13oIxx04W5o7qg
	 K7j3K7EVm+aMHFz+MwrKvUNRYyLLvGpzTVcv6j9WmK9HG3JR+be+IwHOHwIuSf87/A/tH
	 zdZYtF23DkrAm2oda6G+A4QHYA0hYYZYC8uLvQnns82DryOHxYfMt3TpBoBDQ/BCTiTD5
	 W0bRxQMqaZqga+gxcQnF8DYaYnophXrzi+fC6tZ8+MQq5RLzWScS6HkSEmHor6fgltYEq
	 nwzS3c6bgWgX6NBHxlsx4yHN8vSmB9A3tcHzSxfrCq8RnLCYsJnqia/PWPrr5pYVExg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTTzCXSQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F08606A337;
	Fri, 30 Oct 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTTzCXSQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793353910;
	b=wzRZoGOGxn5L8ijCtKkjpOpvwZxTPDntAAXV2vSKwWQe2rLWedsJ9Oo8+HjZV+GX5Z/Y
	 TrTtry7IpFXG8cHOlhk2e5G8F020w49fPb737PlzrzBjOtxBuNEps8hR/08XgQxos4z10
	 rAtfMQhS+z/hXsWecigUWnClvhaSZFsv7LjNXXTy8p4DLgxSl8gzx4IzokULLvPjS3jGL
	 SUD5RpUHE6mttUN/8KaQ6yarZerHqr+3JQFLtLnqp3AD0bFPzpQVKdT1syYfIt+LLC8mE
	 2s3qRcmGT18YI2bhq+8t20Awtmns7O79rD7BlAGVe1hKw/h9YlcqNyxPyDbX9jwl6pQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353910;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=frkiuxk1Rd/ojAV2wzD+GKDvqPPCD0QvXjwcP143p90=;
	b=RyOG/IEmkS+W3oSHquYlBQhVMORvqOJ+v9A/1M3jlGB1endvLjerW5QilSjjBa9wYzP/
	 8snYbwbNYM0O9kloXGQM1TgeBjKCVjqzwHdNf5fG+fXq55M3l6zKhPeM6wsGB2Fu0zT1Q
	 eeTNIv+ppgTgdiUU4eQLI3dAjWMXd2KeTZ6DIMDA+zUMJ8Dj2nXxv/LK2OeojUBjn0oei
	 Lnnibo3gNhiwA5PshJ3sLqCxov0uKTmM6BTonLYMUaXza0i8idl5p1Eo8kURWiHlqm5Io
	 3JY6SE2W5O+stE6BIPJmKEAppW+KHSthyAllX5LByoleauHrPgTl109f+vqv1Bg/BzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 824BD1F00A16;
	Fri, 30 Oct 2026 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793353910;
	bh=frkiuxk1Rd/ojAV2wzD+GKDvqPPCD0QvXjwcP143p90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RTTzCXSQlA/BdAkrOFV8RWEKmp3k8ApXRfcNkW/1YuR3VekfLav3RiNNhmExspGSN
	 64qPzjl5JGbLF6Wz4U0uxTInzlS9fDZfGkMCWsULhWfk7bSXmDTgJPAlwulFOGnHoO
	 SupnsZRrcI3bx+3Te5+/yDwT9v6M9IRghJ6lfWHt5XGmKUPtEHH00TPqU+ckczzK2x
	 TjhzYxm6dNGzMoOoElM/siKRfzKoYS1wdjQVpAAu6lNeOBXY6dHSPM5dEi9M4+153D
	 /9XL1NCO2mp2ng5PZ+a15J7LQLun/R61x9GgV3IRoEZGR3DRwLhWbBwwKOSi8W+fJk
	 mYpVn23dygidg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 087B343715;
	Fri, 30 Oct 2026 09:51:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 30 Oct 2026 17:43:59 +0800
Subject: [PATCH v5 3/4] clk: rockchip: Add composite clock macro with mux
 table
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-add-board-ok3572-c-clk-v5-3-9a43403cb149@qq.com>
References: <20261030-add-board-ok3572-c-clk-v5-0-9a43403cb149@qq.com>
In-Reply-To: <20261030-add-board-ok3572-c-clk-v5-0-9a43403cb149@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793353906; l=1536;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=5um5DvzGZ7NXY6308q7TLtQUZ+TSSmWq3dE0E24Czn4=;
 b=VG4JhmherdSJQ6Wt+860xnxVklWfiy/pC3b4pbpLDrn6mJNkwwQugYH1k2IkD8oHuVsKCDcFG
 x2YZkUemy5tCAKCe0J7VT7xmLoBN3URaUOsDo66SyUMAfe74OUCnm+f
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Elaine Zhang <zhangqing@rock-chips.com>

Some Rockchip composite clocks use mux selector values that do not
match the order of their parent clocks.

Add COMPOSITE_MUXTBL to describe the parent-to-selector mapping along
with the divider and gate. The RK3572 audio clocks use this layout.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v4:
- Split this helper out of the RK3572 driver patch.
---
 drivers/clk/rockchip/clk.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index dce4db3f67b0..bc3a1def679b 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -871,6 +871,28 @@ struct rockchip_clk_branch {
 		.gate_flags	= gf,				\
 	}
 
+#define COMPOSITE_MUXTBL(_id, cname, pnames, f, mo, ms, mw, mf,	\
+			 mt, ds, dw, df, go, gs, gf)		\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.mux_table	= mt,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
 #define COMPOSITE_DIV_OFFSET(_id, cname, pnames, f, mo, ms, mw,	\
 			     mf, do, ds, dw, df, go, gs, gf)	\
 	{							\

-- 
2.34.1


