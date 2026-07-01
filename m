Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53E219FC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865230; cv=none; b=oPbixuvGGnjUzQw7FYIkq54PyczTyNeiT4l0RWsgs+UfdB8XiH9pJxykWsTrPm2JkNCPiFlIw0lolKLKvjhlEP5t4dDDJAQ6a9/EQwAYn5Bqno6dFlKrFGohL1dGPAYv3Uos6Uoq+CKd0wKuLvnEQj4ipZh9cRV/oOstjTa02gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865230; c=relaxed/simple;
	bh=Pzok7ij9OTzneHKaL8dotoYtpUlca+VrVI+eVVwQH8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjzBQDH4KtUFLLokPKJL2vOMcv7o3GthUOFjDwNWt2XlGY5uE7vsafwBwl1uJui6bylt8LBCg5nZFhrX9xo4WR787yJ8B3/UnJ5hoXxVq+WN9WDgWIQcUe4qtdiNMDsXAsEpAAQRSgR59ItUV5U75fzXdxPjfhe2XlGcV2/PNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Rjb3Dg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Rjb3Dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC231F000E9;
	Wed,  1 Jul 2026 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865228;
	bh=7RxcwaXrdl1C8GAyd3KJJ+s70ZraGGPWlP6K43z0ioo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U2Rjb3Dgn7o7LYUULGA9ZNgIM8QhIdRDwRb1kutxDm5uBD4Z6YGNV0FBQo5qQugJX
	 0qIEQ9dsewKhHsWGpg/cfuUUfS+OEtUqbS+JLmjEbuaSZPvpTWQJF3wb25QR4JqTGU
	 OHuSY1G5hoLGRJqfFBFlMqMuY6cCRvUyzeBbWhBDjwdSLMiwtxHeZ9G1XiawNJ1ZKu
	 0vOSlquNat11HDCv/+88FfttYmcpodU5b4ZsfehrD3EazuuEfIjfwY/53QFBEUOwcL
	 5AR+WsplWbe5m3Al4tjiYwzmKI26cgU/YsJGqSsmEtg7jGIRClUzIztGn7iv7DwDuU
	 a2xRcxpnYBzpg==
Date: Tue, 30 Jun 2026 17:20:27 -0700
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
Message-ID: <20260630172027.5eaba39b@kernel.org>
In-Reply-To: <20260630171016.11c02dec@kernel.org>
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
	<3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
	<20260630171016.11c02dec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 17:10:16 -0700 Jakub Kicinski wrote:
> On Mon, 29 Jun 2026 10:46:03 +0800 Ren Wei wrote:
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:GPT-5.4
> > Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>  
> 
> Let's do away with the 5 reported-by tags? You can use a tag for your
> tool or your team, it doesn't have to be a person. Look at sashiko or
> syzbot reported-by tags.

On second thought, if y'all work together maybe there should be no
reported-by tag at all? Can you explain the situation?
