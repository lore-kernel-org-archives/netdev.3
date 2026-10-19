Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218129B228
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372053; cv=none; b=hVt/FzRI0GGDYo3Ij8BrVnD3zKZyVXZDKQ2Cj+6kqB1qaC3aYMz+xXP75PT8P+1vQ5EUs2rtd34jEzfFCSkdH0WdmJwJ67vSc7RnuVQ8xLNQ7wgUBA+Awz2Sft2eb/vcuLQpiA+D0DJlvxXTD+A+wquPEplf4MbIPWb3YUHMVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372053; c=relaxed/simple;
	bh=mIiL9PgSJJ8fjuyW++lfEH4uifioW1V5PZY/k9OTv5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkrEn7WgT1IW84TQ2hb+5PEvV8MgeUoCqw+F91vSGREwb+QQJyym/Z63Uw999pc5MYCe15td5yNs3UoE/KHrl9Nhp442n00VRZiUylxQpLL98NtCh3jF05834hrCZa3XzvSF+mmDbp+pA7iJUNbVXs0zisplZdUPfn3j/+Te0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=pdpjT8dR; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="pdpjT8dR"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so3980784eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 18:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792372051; x=1792976851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwsY2GW9uMLA/+aDo+zZetHYH/MOnEHa84gDTy3J3Zg=;
        b=pdpjT8dR72Iis7eWYhTg1J+Li4ygPMsE7ibvytonFeSadqQ8Rnqs+DKxmWpIBBsG8M
         RRjsjNd7XrWLqODNqBQ0sIcD0GYEtojWeRd24nXiphw25Gn0PnHbbm0u9BZClt9hFh8a
         mfcC+OcF3Xb9f3QpbMpFrXXBtiU/sY2wlC/qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372051; x=1792976851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwsY2GW9uMLA/+aDo+zZetHYH/MOnEHa84gDTy3J3Zg=;
        b=j2L4AXnzE2cR8yWdv2QigClusxz1A70WajyCltZAl7P19tDhiWf/cdUYPKJMYXYLj7
         nlvhjO/cWypCuxF3bvZPca7Slgi2r0Wbh9hwZy8kNpTMoZO2woJk5SoIYh++RzQEjzxP
         mIgY7c7JkwF53V3E5JGoUW4K9u6qGlG4/AxCGYsgyKJzz/OZ7oPtA2awSjkWmm0qxxxH
         v0mZhJPmknvO4243tC2HpkEIl9iOt247qXnQEmq5ku0UFIjBMQKRLNP3OPydMJqXQEoP
         /kA0XvusNyFWV1L2ldn8zPC6jSf7GSuOZSIAIT644o5gxe8yeyW7mUDeGA6d3IZuxQmg
         aD3g==
X-Forwarded-Encrypted: i=1; AKwUvByqALNz2D+FwvJc8ojRaj9bMlRapLhRNs8EWtwWMRVgs+hdKh8kW968wNqhkukMrvWNevJpors=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMjpBWW9k5ShBh29Q4bv/jW+MuodqinybHPyTvMF1HPkfu3JUa
	WXvDxqp+vmBGnRJnKYD++dAzaSluCTWdhjZN9bWkjRXdU/YSjHsuYboXUrIneHCGZn8=
X-Gm-Gg: AYBFou0vwT6JFiCoLQrYRDh6Hc15AfSZQ93oZSkuVwAkd2uvLNVSb9W7eRMRI9RW2do
	HfCpIPDQpSNL+/5y28B0puGDQ+86wDMLpCdBTxMsKZvMpIoquCJjfvyUZjcFgTS1gLhM2OvrgT5
	0WKKA0LTBHH0Mg8nCfEfXhITkBltVt8bafy7q6QTvu1BPGhaiGo9ev1PH/wOdQAXSN2hgeqzopa
	RBX4T4FPrs8NabYtjhHbjvCSHJgUpV5sC9zZudKU2nESnpEVJFlToE8SNSLXcKt6nkTwgvurrFD
	s8Ib2bwWZBmGZG1wZdJZ8B2yyKBtI7rXKBQ4gb3T+PP68AhbQFulzKHrzvgL16OVMdPqgwMo2Tf
	1FmmFVoYz3qIcIJpEVVtNFNQTtNWdlrMZuKCRTXN24WSObH2e8AXVJzsH4wp5cSovjdaVAH9YOs
	LstYPNGtceL46Wexz0IVt9qOZbL97sBYjbPIb3Oy1YxehhXG2Li1xeyFL/2HHjm4oMczHDru0rK
	Ql9sMymBPKD8xEkbO17/nEHmhPW/nwRtT8HwazW3kKRqeF6TwnxPLlpxYVgWdWK2g==
X-Received: by 2002:a05:7300:7a99:b0:358:f678:46b6 with SMTP id 5a478bee46e88-361a2343165mr9757670eec.22.1792372051354;
        Sun, 18 Oct 2026 18:07:31 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm25934235eec.22.2026.10.18.18.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:07:30 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: netdev-bot+sashiko@kernel.org
Cc: 98lawweijie@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	law.wei.jie@gt.tech.gov.sg,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: usb: pegasus: check rx pkt_len against the received length
Date: Mon, 19 Oct 2026 09:07:04 +0800
Message-ID: <20261019010704.90465-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179229290253.3135.18168766657798775955@kernel.org>
References: <179229290253.3135.18168766657798775955@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko is right. Will be making changes to this patch (2/2) in a v2
patch request, addressing those comments.

    Wei Jie Law
---
pw-bot: cr
