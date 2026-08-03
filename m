Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C0415F1B
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766677; cv=none; b=L0685y8vhttBUmidOnCQcJCn2Ojq5G0HHyoeDSULSxCRZGBQ7/VajwiLNG+IkI9NGdapx7RoY3SVnWYv5X+vuMqvXYUMGX/fQtpP0NvH5GXfdJkmvPcoHyG5EZUUT/G21mNx7fID+tmjQ2+EB4R4ESp1KCxyJ9UUZGd2fuebTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766677; c=relaxed/simple;
	bh=G59FL0kwCIrlNHdd8hEsY83x8QP+b4bNhWMWSKXFaE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8HtaVCnw2rIdx54qcT7f7PdCf/hyHEr3MNUiBUxlUsnbXSuJ6hKj3TWRbxxt4KGwFEKrvRMk9d3OmjRiqdR+Km1AVhUQvWG4U7znyp8cxAcA+yagoJu7Bs1Oft2FDkzW2CUpUssvXjYuIGa8d5OIgHzgOjGUzAmViXgUStfGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0PGsxYJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0PGsxYJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3406724a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766674; x=1786371474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YUTKcwC82n8dRAk6Rq6PaXfV44JobcORSU/s+vRUxE=;
        b=n0PGsxYJi3Zcw+1Xviepu4tR1udQgxMMX5zE4+lqLoOLQcj49+H4dz2TZbyqvNvLpF
         std1ZJJOmklckUJDsi1AKmPkX1M+OhquwW7TGydssSkgzG2I1aqtt48vg/8ifkvjE8Kk
         pIHrNSENB48djBcDhPKMsJ8Ami/++Io/A1L4CMviQjrl8CaQ1UUSAJDL/I6cQaxV9qIN
         SPhZZCL9nZe/jNj+lT3fOtJ4iBOufGVtHAuNvxgkNwPEfapH1I8ZTpobLIBNsEteNmcS
         RhIrC61RUq6Pn3y/pSKNjDXv4hK7ZFhC4J36dG6Y14bfsXftkn3ovjv70Q5FMxE16ekP
         7tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766674; x=1786371474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YUTKcwC82n8dRAk6Rq6PaXfV44JobcORSU/s+vRUxE=;
        b=WPo9fdbLyGBjLSgxjI984HaHFw6IlzqH85+TZBy2KQHx3aEJ6yNi+5HmSxxW+x/Sdo
         7DWXmqHpFhSRE2T7MHGc4L+wf/iN+m88tK/UFJbghK1TJW/nqWab4t/xJV9dvcuKW0h3
         NID9DmL6M+f7W0qt89yrem7aFlikW8ZkdYarnbYnWSF4HOtpvYWFgxe9/ue9cg0TGz25
         +IUm89dpYJNh9FBPei0TRQmtjUO/sWp1N4Lw26b+wz4v9zoM/jN+9+dnCPx0uYwLcxjB
         NjjnnrC78H9KhKfBHBZW/8T5bxA9ijtgA7Hw9RVlhxxtMgPLWWLSSUwGryzBEPobbqfG
         s7Kg==
X-Forwarded-Encrypted: i=1; AHgh+RoJvjyq0wW+X0KcH46l5lbJNJLBJKf6o60SNYCWViQe51jYz9kNb2woBl/j5dlXPKB3fNDWX3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvF75qhHNH+FQWUsU4E8uCXTEZaz7JkH4fkYmKhgCXXJxw148H
	L5Sp/ikCm53qcjSrhUzqNgqcRNFVPbtU6kxp/ihlpzZavo9TthmoXtk1
X-Gm-Gg: AR+sD11jU8kHi5TqeakfMiQgMOb2nAVyRqVXYQTkYvsqMHiXkrl/u3phATt4mXUo8bF
	5FTqW/7ylb/EmUW43sHFKJQH90FjqLdPdEdI/Dh/r6JBQW/JvJ242nr7T0Edec6zJTwPQU5aeUr
	63/OKlOcdn1VhpEERfVitJR5DMzL6g8uaBExMI3uohi0cMO2oz00SyhaLxTovrqlGdJmYh51K8z
	UDUFqp7DdyVz+RNfMwYNp+dfpsIZ/ADXZR3w6Oetf4VeA/aaP+VFZxbPv7Y89kUdXZAGfSkAZan
	JYZmo14R4NnpubN6NDffmRlAMpymHU7yu5HYY72IDSZv8aoNyqUypQgqQ2kWgh+kVls5cFaww5q
	Rdj6dK3su3Yj4pwWpABKy4fmbemzY7I9AvfyE39rOUhopfXHaYOlLOGLTc1Gz6VZGLdUsY8MZer
	vZn6TQfsTDmHmvmL4OyEOOEu3qLhY0ySQ08suG1YIrgvFznxyTQv2FZtNM+cxzfX+RFOIcdwhU3
	5mWAUYhCPx2k3vIaAEaZd2abffI4hU=
X-Received: by 2002:a17:90b:4acb:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-38fbc4313c2mr9516829a91.13.1785766673989;
        Mon, 03 Aug 2026 07:17:53 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:53 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 06/32] clk: mediatek: mt8192: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:33 +0900
Message-ID: <20260803141659.559129-7-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_mt8192_apmixed_probe() in clk-mt8192-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt8192_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 124294ff468f ("clk: mediatek: mt8192: Move apmixedsys clock driver to its own file")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
index b0563a285bd6..e6ac40e2f12d 100644
--- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
@@ -176,6 +176,8 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 unregister_gates:
-- 
2.55.0

