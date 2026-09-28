Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6E5013BC
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632503; cv=none; b=WNaYRFpjscHjHRjVHKJ7Uez8v3ulhV0JqDju/K4z18YWR/kcC8zVOkaIv94arWT5FtarDTTe7Iv+xf9JZzHnioMm+N9ugq0zuN1RyeGjGM9DTGwp0kfJzBeNnig/IKlAab7ItyS42vPWHKPIAlOhyRc2tJ0u7ndLAtXSsW+buv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632503; c=relaxed/simple;
	bh=4aBCe9JhpyN4TkjwCmlcQnGVb5cYh2Qy34BAJ5vWWr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7lul0Rc2OLHJB7Hti/1bquq/ZUK3dP5TA64OYbqWN0A/BKsvnW5mm61nlX79j35HvznoHb3k6HQpZDZGtQvYedwCpQq4MRScB+O8NikC0dsOmqT9Jyiu3jaAePZLvmGgwuklK0ImsO+7ABZ89zXTtvEZ13TGA2qTFF54tgX628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DvUaaZIL; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DvUaaZIL"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d73f71a49bso1022574eaf.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790632497; x=1791237297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4aBCe9JhpyN4TkjwCmlcQnGVb5cYh2Qy34BAJ5vWWr8=;
        b=DvUaaZILADnwMVKEUX0PgmuY8FmMMzWHVR7VQffs6C2jOX1gdv01eYO8hjq5bmj1I0
         YhrZ7JUU24ePSO4mg0Zut1ABJ7tcrd0DIPH/Kfwlc3VCDRdcJjM+FDpI9m7j/n/H0v/N
         EcYCH7zpN1uaiXnJalWp6Jj4doSd/8uLPGXEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632497; x=1791237297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4aBCe9JhpyN4TkjwCmlcQnGVb5cYh2Qy34BAJ5vWWr8=;
        b=C5YETY5dBP2oE95u1tNJANr04pxI0Lj1M7hMYCoiwS4TfhRUMbDRszNABIRR9CFgf3
         Nqk9seH94clB9g/rtz93mZLrKKmjBMJpwcOatB8PVnC6JBbZK6Qc/dOnRojxgAtP38HQ
         DuLsVy7GJ6IJQGg7EZP3TA76S1gsq0epFefgKcDFV/wIBNzipC40qIrCuk8h0+cljbKI
         u6wVX92oQghKQQ51ofq81zNtqupBhszT+VPkAhBtHcB8rCqgRrfxh12Tf+zVIpa87Vys
         xUuj5neRNYwGqz7+eAeVPKlvgHST9/SmewtRUUbSayFIqqzyhgg3nqiyphxYfbGyOnU0
         6krQ==
X-Gm-Message-State: AFuF++k9iWI9cDSZDxVoRq3FEcy8huzMNPXhqXMR6Ldf6wS3JzXmf2Bb
	DabP2RMrV6dIrWAGTCtCqaNe5/LdP2enNtlhSdNgSsVNe1mQZUSPwyC7iLwh7eVe70mv6feeTVb
	Y/SO7GVABTQ==
X-Gm-Gg: AYBFou1nTeyiIVnITwzyYCvMY1ISZLU1FuzydL3w2xCWeXvqD+7GR9Ibh5wYZYUmaPf
	sdcUPPvLrrbdQx2fsIIV+bL1J5x5Du4mV2xW1FjaeivdJnsJWH1QkhGBXDQ5E2qWR/FeAGuunVH
	qKkmfZ921PX8CfyPXQTBdiTRKe+HUA1rIjXjoz8fJ54nV+TDZMMYYpq+PXgJHYdPbr4GnfnBPlb
	3oiMCyeswvxac5RyBtcLbgNc++h9KzBt433p3U1szwffjeOsveQTuZxpdkDFjw97l3Wwxomk3uk
	MPlUdDaaVXn8aWlA5Odx9yTuYL/c5WGHeyLohg/Q5BI1rUDY0RZFb5EmDfVWRsQoBhm3ode8pjU
	bU35tyUAIoRO6NuiyX+Id3Y0crACSi0vWoHcLG58El3WRTmhaNUyeELH+FMdi/0HaB/yO8qHUXS
	egTpN4z10pEeffj2r/TCEkD8cK08cTQCFKZyf/jjEPp7Jx7ErcKY7rfza5LuM+eOs5PFYiAF2bd
	rXPCpIJFwT+zwEO4XIQXXx8uwFdUnJLBKVavr84zmttt9bmA38ECqV+y5hXKeS2gwU928gx7uu2
	frQ=
X-Received: by 2002:a05:6820:1798:b0:6d8:3caa:a468 with SMTP id 006d021491bc7-6d83cd96f72mr4817511eaf.77.1790632496519;
        Mon, 28 Sep 2026 14:54:56 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d57ef36b0sm2605923a34.6.2026.09.28.14.54.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 14:54:56 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/2] tcp: preserve RACK tracking across partial undo
Date: Mon, 28 Sep 2026 14:53:04 -0700
Message-ID: <20260928215440.25109-2-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926002520.42955-4-nramaswamy@openai.com>
References: <20260926002520.42955-4-nramaswamy@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Adding the maintainers/lists I missed on the original CC. Sorry for the
omission. The cover letter and both patches are available here:

https://lore.kernel.org/netdev/20260926002520.42955-4-nramaswamy@openai.com/T/
