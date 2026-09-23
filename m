Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AB47F3D2
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159928; cv=none; b=q/xccwqnw40pmAGui6SphxwYCc/RjhnT7sBfsiqcN2Ah2J4p5gQThmfdiSSNNKL/K+B7Z+0msBZnFcwGeTVWEehbpVVBhbA2rUBuQzuUPfD1laTL5MFjaDZCzrvkIgQFlMgVOBLx/WdsICe/ejX6hzK3RNamu+UTQtNrW/14DSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159928; c=relaxed/simple;
	bh=Xm1AbrmWhks9R/eN+A9ynqbUJlz5lcS3tpvAQWAnyl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chaFXDKRRZqupKBCfyDxZtvkRpwtD9koKRY0b+xN8IL8zIfzUlQRFJKNBNpQkWnEuqApMNNB8ZJyqn9kH5z7rMvcqbUGJTc1TKXNoVOlAiG92MtB/8doYzJMJc5+3y6jUONJEB8nLHDdBlmye8dmYsaT0bbYskM1MrmDQvaLU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=nL3drfmu; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="nL3drfmu"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-328664ef791so470581eec.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790159917; x=1790764717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm1AbrmWhks9R/eN+A9ynqbUJlz5lcS3tpvAQWAnyl8=;
        b=nL3drfmu9QgRCjijKrK11nuzAeEqbQnthf7tvoZa+Loz2mm5DHWL68ssquJW+RhOK+
         CwgX+nwxt9qRwWVxjl7oizXREIyTpN6rfa99p6ofNno6qBn7nj04aPyoq0ibMUJXETta
         pecXwxVxm/Aooz4rzuBJD7DQsOzArUL50omCuJ9nSKpjETdybLnb7Oyc44Gh3llMgvke
         BAWHZbYzMyuP8VDGHT/s1UE+SIQreQ65OLN/mNQKRByTCE6Ags8nlQs0ItqneLC2HnKV
         LJbdfv7Z3Mj6h49EVNmoWJGmtiuime7tRe17dL5WQ5/F3gPyZefiiV4FLcCsXynVWC22
         pD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790159917; x=1790764717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm1AbrmWhks9R/eN+A9ynqbUJlz5lcS3tpvAQWAnyl8=;
        b=ihXtmt5McILSJDIoT+XbyS2IJAa97mWMITvbVDVVU1w/Zupz4IWa9T4BFzyG8g2ijE
         CvziQCBW2fQzkTs0InOSMstFcF+C28iLFhwlTzhI7enL6587fhdeXb8/geWfbMA85DDc
         mLHQsmD2nFkpaN+K6b+Cet9ivjUTVP/jO9h1o6LtEQOqbaNT3d/V0P7EwizUNMVC5f3z
         MmjxLMklnQ78oZ8msWOEXs11pzeIrqPrPaIeEAjAm7/4oJRRMLbOIlD9nZkySSnesJRP
         6cKWgsI2l7YjvCj4PWjoeZwq4cJXXw8FKkJovbaRSlcddKr9GairMgBNo5unXXQsK/XC
         X02Q==
X-Gm-Message-State: AFuF++lG4Hj07BsrU7c4OxGHBM3a7zb9VrIih3oJdHzVdEJC9PGfcpUa
	XQ2U4LPY0jOMB/7kIPJaqeKzFfiI+WIgIJxUsd45ocz3qP7Z2Jk8GvUY+92GRLqA1biyEltqwVN
	TC/55u0IQLl2IGpbL4WhxTY0uzNCvhLUIv1YkTQlKRamrS05IMsBXk1EkBMjgGrYsO/siskRf61
	M=
X-Gm-Gg: AYBFou0xAcqsWhUWuuQhxJ/5+30q0nuUC2sKnJnWW2Lk9Hlh0VNDbTsVLKtn3Pn4QkW
	V2qddp64itg8gV5GKjDAN02ovOs8P7k+nj3l4wBArlAV639GSPOH/9jMn/fBvwQWE6/D9V5NH4V
	EOHHYAE5UQ38Y3GmiW+yFXyLr7lV/hXxtLD0NWQsb07WtCNIphiQx9lM3u+E3mdUOuaw1eJk3KL
	bysqsQ/g9KqKyVl1zV9Ki+oPRSe8pOhm4mfp23o8XTgfvT5W1U+wF98sQ+znjTBtpxw5XU++4ZM
	AkV/pWZHJjRdDMi871w8alGIZBjF3NsP+LHDJoDZsPHEJhhY/pD/KlHucRf5kHljHR338fofZJL
	e5h8+pe7pcbven2x4nE1tKyZ4gZHVptgqb7DhBWyeTx58fGtsrqUB4yeY4MDZ6/47xzAIq+E3Jy
	Hx8TLc8DI01td0ZK7WqDTZ6t3EC2k6kNeaTmOtmTP/lMPPeLhMZXPJidbOLUHCgqiYAld8vuLDY
	mxHS11NqT7GAOjBJZsnjg==
X-Received: by 2002:a05:693c:801b:b0:33e:d4ae:e10e with SMTP id 5a478bee46e88-33ed4aee159mr1600774eec.40.1790159916455;
        Wed, 23 Sep 2026 03:38:36 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e975223fcsm5412344eec.31.2026.09.23.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:38:36 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Wed, 23 Sep 2026 18:38:25 +0800
Message-ID: <20260923103825.4000903-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.eb2b72530041@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com> <20260920131231.3610688-1-wang.zhan@smartx.com> <willemdebruijn.kernel.eb2b72530041@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 17:07:09 -0400 Willem de Bruijn wrote:
> Somewhat tangential, but an entirely different practical approach
> could be to disable BIG-TCP when such a patch from BIG-TCP capable to
> non-capable device is encountered.

That means a single device in the topology which does not support BIG TCP
forces every other device to turn BIG TCP off, to avoid the degradation.
So with mixed devices and a dynamic topology, BIG TCP cannot be enabled at all.
