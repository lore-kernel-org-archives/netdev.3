Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121928;
	b=yaEP7HGiasETYRzuMha4MRdR/30MAo+cdNYqVqT1E6oAZrHqSN4lM2bAWnFcP9NkE/SM
	 aXJNjlfmHp/KKdYZO7ltt3AkmttcZ8gHg3WmuwL8GD/DFxtLgo1njKHsrLbGZGQ4AFS0Y
	 SyZZlnMotCNYBZhHhQX+OYymdMijbzNZj1CubPssdFyWEFObDz1Xcha8Y/9giHXx331FJ
	 wvMCG2mT+rAdW3yTH7iam3Xbpsg9IAz+RoY5ElgBbUn+3TSjrfbMoz/Yrg1ZFM7i4vGac
	 utmqaHkzbfnbEq7ItTUgt8dNTp7JhTnn5gzLfspM+1zv0MK/+PbIxm/c7w1NK0m2vqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121928;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=X5czpDJvdoq6SKdd2B9t9OkIGtq9RQ9Vhw5mAJNqi3rqiqvSi2dDMVwLTGn2O8nPsxF1
	 gxgjhSNC3mUB3pHUj5Cg5pL5mTOFndVYgx7Pyjc2IQtdaag+uCco7a2SBjS2gu6HED1W4
	 CvhdcVbjFdW0mdwH0OpV6YgUtvVyy6RQGYw/o96B5T6x6uWMl4dS+bGCRzrMug0dbwcbw
	 BpTCKK4Ty4uij04kDseRf9YbaZQDwA4bMxfFhklMUAMkICUIuku7z0mY2ZhhuJ1fWxLiL
	 mZmdlaLGDNG1wZCCWeAzbJn/TfU7CPhEiBjBpz4E1JXjyzUlrfbVIym9Sh7/Uezc9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PL/aF0t5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA370606A31C;
	Sun,  8 Nov 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PL/aF0t5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03171F0089F;
	Sun,  8 Nov 2026 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794121927;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PL/aF0t5uogk1Kc7sDp3cv4cOJid4hmIH8GqUtC3TCQJr19sKuoPI9beTN3b7UtSP
	 ehhKXNyLQKuXoCzTt+uMXwlbkmV5V0yg2Y1ERzjDpr2Aqpo74knlyNJD0DBQ5uTe5h
	 LraYInkhDj8wC/T/SiqGET4VegpXdTs3lOw5VmRmO+xTThaM5nSUsKlvpOO9Z6o6Y4
	 6VaWdvu6uAn7opWx+Q2se0onBlFwlIi5Nylyhdrxvi9naQ5gs2GPYWb3gOzWYhaLCC
	 3vMFLtAnfQ1ryRItDo1qnKbhzIwnpZkX88RVsS9m6orVKSPmnFyE2Ets92OhgcpOhg
	 LAial2cuVRwUQ==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH net v2] ipv6: reject routes without an inet6_dev
Date: Sun, 08 Nov 2026 07:12:06 +0000
Message-ID: <179412192613.488859.3852100105324385639@kernel.org>
In-Reply-To: <tencent_3049FF6D9F23419F56589E244420973D2708@qq.com>
References: <tencent_3049FF6D9F23419F56589E244420973D2708@qq.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
