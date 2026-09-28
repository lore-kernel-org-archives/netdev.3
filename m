Received: from mail-ej2-f28.google.com (mail-ej2-f28.google.com [74.125.228.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE94F96D3
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633361; cv=none; b=aS5aQ4J0P5XuaiffXVG3lacjVxp3eHNhZEncG4X4v4DMe91lAR6pBotROYAl1oewqMD5g4DUKl8iJuER5IA+ZRnTH8hEXchpmnaIlQFOQKfpyFO6cabhRNY7OyPb4LTauIaDyGWlggr/FR/nghWmLNA65evoZ6jS/VCR9t7lCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633361; c=relaxed/simple;
	bh=rZpmAD2x0KQnc/mc298y8EsNAb64mlW7AF4wYInWEok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP2W96pgSZ+iGo+WT4OBrci0L+0kr/N3qa3vizv+6IudNse7+cRdoJekkescXPCELazt/K6XdhzB8YdNkIaHqamxLR3BhLWNRL/6oNpNQiNVK8NvgY9YpvGtIGnVzYcf7b8XWjC84/xyBm0qS/p+Zdpin3DCzcEqsH/zE9Hr4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qT4t8M2b; arc=none smtp.client-ip=74.125.228.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qT4t8M2b"
Received: by mail-ej2-f28.google.com with SMTP id a640c23a62f3a-c2af3701927so516106366b.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633357; x=1791238157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZpmAD2x0KQnc/mc298y8EsNAb64mlW7AF4wYInWEok=;
        b=qT4t8M2bC+oDpuJX+btxKlouHWBNUN+PaROBkJX8eF4+ZLyL1w0XM/ACDzV8KPaa/Y
         lzLVpKP3S6Q8QSllo7MUtzTNmiXyp3j2aa7TBI/T/dy1zqplloXaEc0NA2jmtzg22llJ
         k2eGzZMG7LFi2I8EVFw+VH83Zke9dFTKfWcaMkY1ULvEtOQT9+KPYwCzLsELdtQI2uhA
         ZC0T4KKNzaZbgp63ubJ8wt/C/vel/7crtoBAcOxziNUP8QKga1LySeKeylNg6TsTp7eo
         3+3UwV1D7XUOYl/3faMCacLx1lv8YrQz83xSk1F5D3fJhuTG+ced26dEuFRfN0VTiXKL
         b5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633357; x=1791238157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rZpmAD2x0KQnc/mc298y8EsNAb64mlW7AF4wYInWEok=;
        b=UJew2zIa5vbjKZAaKNqunszeSbmfZkgM0UVaQsfAX1ifOg8uNM8VwXHaPr01En7N2A
         8/xBwvhiMxtJMJBZVi8wp4+n6jQ8TVayrQ0WyjB2hwEKVcC7wAVTNm2R11+ZGM/qZ0dR
         42IKPjJd9U1fEJL+LrtF54p1Fi5ApzV4l145um0yvRXrjG0zh8Pto6sRYS0vzb1B7Zrc
         eHcDU3e7ev0zxDZkfoWHRE2jytHQgqKhkzdyUtVQU/zukVl4wwdpeWLAYQ/u7BS6e1Up
         OzmJ/fPtbk+EeL/T62l4q4e6GbDcy9HCLdNDNGVT3Htum4WyzUF6Yy8Xxs7T6hpflZZB
         k5Xg==
X-Gm-Message-State: AFuF++lR/1da5roWa8ezhwkXrcA4SJFgeD6Z74NzUyf4C5RzNSXVgoyJ
	8PriXq0FfwWrLroILJnKpta3cWPvKczPxbxyxkAENnED5Z2Sm6FHS+ij
X-Gm-Gg: AYBFou3qAskksv+OZ7k4ZNd1XqAMiHOuzxkNpU/GVPcc3dKykrndaTz2S8touUwuAAG
	dRTK0TfKApgRVqxVyTRcpy/t0BvT/B8s6e9oLSVpS5kRA+5bZMAmtU9J5+BjthaZec2/zNGxDLh
	KgHSeZnDOZOTVcbe/I6TEYM4hHGHpPLPAp44JdFbbxUr3K1TGI8hs6EbyXrdgN2eJlii3fI8hus
	fa3z11goaSrgelKrvqTGKqagUH/46f8ahjQF1fGWGTOQWUoh9J0UkLGg0rXmaZx5rJVH1q2stoG
	c9ADfHvTLUyXhii4PY0Va7oCjkWzEYYmBi4GusUxHFKYjQYLUhSZs50NOFyxUKzXZf3WKCBhudd
	PHeAt/yV/eWkbr7Ubtmo0C5LRhhweIqnxWuafKuzrbHZDY5CA0OpfJNh+4AUktlZ2CDwpEF8jMM
	9asOU31BJSloPpo9It3XQeu7v0NJP4WfDXsNB2g8Nxjxwy8G1Wgc9EzcUBV4Gpr0CjQ777oMZbG
	BK63jMbw2Jk3AUR1FdBn4+wF9VwFGyHFscwFPw5clupAhomjyefmqsX
X-Received: by 2002:a17:907:c24:b0:c29:f5d8:9c7d with SMTP id a640c23a62f3a-c2ac22cad65mr1258773566b.44.1790633356629;
        Mon, 28 Sep 2026 15:09:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7352336sm533842866b.16.2026.09.28.15.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:09:16 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	ansuelsmth@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: qca8k: propagate MDIO errors
Date: Tue, 29 Sep 2026 00:08:58 +0200
Message-ID: <20260928220858.1982-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <179054715863.3145.10179961093285192493@kernel.org>
References: <20260923215748.1336-1-yongzhao.derek@gmail.com> <179054715863.3145.10179961093285192493@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 22:12:38 +0000, Sashiko wrote:
> qca8k_mdio_read() has the same pattern. Could a set_page failure unlock
> and return directly, or use a separate label, so that the MASTER_EN
> clear only runs after page 0 has been selected?

Yes. No transaction has started at that point, so there is nothing to
clean up, and the write can hit a register on another page. The next
version returns right after a failed page select. It also invalidates
the cached page, since a failed page write may still have reached the
switch.

> Doesn't the same outcome remain on this Ethernet path? Should the check
> after read_poll_timeout() in qca8k_phy_eth_command() also bail out when
> ret < 0 and ret1 == 0?

Yes. The next version stops polling on the first failed request and
returns the poll error or the timeout, so qca8k_internal_mdio_read()
falls back to the MDIO bus. The same exit path also leaked read_skb;
that is fixed too.

Both problems predate this patch. I reproduced them with a userspace
model that compiles the driver's own functions. My board (QCA8337 with
its PHYs on the SoC MDIO bus and no CPU port 0) never uses these paths,
so they are not hardware-tested. v2 will be a three-patch series with
one patch per issue.

pw-bot: cr

Thanks,
Yongzhao
