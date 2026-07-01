Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9CB640
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864618; cv=none; b=gU6QQLh2MnD4n40cc8tuun07I24IoEBnacf6rYHSG+eGII+jmBrfdVurli2PFDhSnPv0Ge/kAce1BCljokOH1XIA4CCaNwhNaDqyWXIpSpPbbW9vV0HFEiCq6t1WITboAkQeaZJkj+B6+h+3E7k/MlltG2GjtGMXtGmKD9WLFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864618; c=relaxed/simple;
	bh=3CWakuO+Zl8i+W35j2Fcoa23621kOC2Ej8UGhjq9J6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0OwIDgA3si2ereMrUoXcJQTvvhpnv59/fYJhya0wTmsTHdg1S8xbXRtIzajhLO2odpVV6inr5aSVgXg/KIxauzy/TSdyQ5+6jjeSJlFfTd0V76KuutE1csvO3z7MLeYMAsLq4yLqN3faYlfTEGk/rmTZOvYSCa5h923ArjQHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5mSqD8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5mSqD8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3341F000E9;
	Wed,  1 Jul 2026 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864617;
	bh=4MzL+D21zhdUHYpaJKr5W49AaOCxW0dEPvXX3kHVLO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T5mSqD8m6wYBahC/KMspAj0QXfGibItNDYURwUbxKk/uB4KyW/rVdQGMTBvFKk0i9
	 lDRygXYMIl3ulvcF1Q8G3z8QjJPGvikZ1n2pMKwrs46wVNNSIA5cgHGktx8oEKCRiS
	 oz1zrAqIWxJcBGAT2xbHWJwKI4uuZvQilgk0R9pw6dylEXBG3okqy4899TF0UQ+YF+
	 DZViLsK83X4v4EhsLQCkH59Ixb5ImCMtp6+A7pdUGsWRlF5Knl+kV706/hbfMzuBgx
	 F93cNSRN7COqcsGACSUhXgd7+6O7Z8SVzY8XyulGgEFe+/bXG9kh6aWSMhWe+Sv/ti
	 n/j0XTnxhufoQ==
Date: Tue, 30 Jun 2026 17:10:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, peilin.ye@bytedance.com, cong.wang@bytedance.com,
 gnault@redhat.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 bronzed_45_vested@icloud.com
Subject: Re: [PATCH net 1/2] net/sched: act_skbmod: require an Ethernet
 header for MAC rewrites
Message-ID: <20260630171016.11c02dec@kernel.org>
In-Reply-To: <3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
	<3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 10:46:03 +0800 Ren Wei wrote:
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Let's do away with the 5 reported-by tags? You can use a tag for your
tool or your team, it doesn't have to be a person. Look at sashiko or
syzbot reported-by tags.
-- 
pw-bot: cr
