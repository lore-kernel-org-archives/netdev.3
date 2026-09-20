Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF132C1584;
	Sun, 20 Sep 2026 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929715; cv=none; b=eT3qyOfTadnSgO7+Zomi6I/+gaVL/tF/SfCcnB+jdMQ9BPfw0O5wt1zmFNLEpZ3vCSTwStxVQ0g7+v+cD4fs6Ys8IvlJvJbL82Jh+9qOXd6eYjS08ThlTES/vCJQtH5kZ6O3H3rY1RmtvzB9QoqyUyLzwOqISPT86OZ5hNX6ouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929715; c=relaxed/simple;
	bh=iWj8cBJmw3jUdd3DPK6vVGmvJSsAuPFeSDOy/jVJH58=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tzJjPQbhCWMzd4eLbdA0OeVuuzj94BtT2somyiJH7DCK9A75eEHAbpLC+U+62S6MMcs9wCKVUqNI4xyJYz6Co9sGn7AzPUnZFjzs4ez4Cg5T2+/5gK/Ds6aiX978fJiD0ouIxvEmJJp/RprFeefe5cE9uDdzCNPfgBh68vXa8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRpGh9gB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRpGh9gB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2531F000FF;
	Sun, 20 Sep 2026 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789929713;
	bh=/mSUrvwnN9G5ZE15AFtMooCJbkEJcA3Ppux9ve9UoFk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=nRpGh9gBVkFCn029aPZwOQKJOr/9VgJp/uYfomVl/kXLuAkAireelvs2aImbhy3YW
	 KatM+APxitJx46uoQ9hWYGUf9HHVmnJHFPPS1qO6afODmSt2wvBGoaaLRX2nmCOsC2
	 etcBDKuqWVyA165c00ijxN4NxVgZuye1y94lJH7idYIhIkvgQBCwIr/Go5hmZQWvwq
	 v5IQcTeaF7FcorzaChnbah/D7xqG3wgky/Y/QdTWKpFrYj6sx4Zh7yYMo+2TZLc/BC
	 NcFwxkKVcBQrPQhJSr2GIVy62dMGOwx8ZxfsO4g+jEVoMp+Wu+xzsRLYGvbSNrw3p8
	 jwNpcApuRuAsA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 897F2F40066;
	Sun, 20 Sep 2026 14:41:52 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 20 Sep 2026 14:41:52 -0400
X-ME-Sender: <xms:8Ciwaq6Z4HfTPYfWWpxobNbFEKvw8125KFdt_HzKOI-zu_xDZCOeTA>
    <xme:8CiwauuWqkCSEVrE_nRfHYR2SuFkq23-jenwnNmGVWygiYc8cU-My3pjhxWSu9DP4
    yrwCWI7CXJbdunDA-pHy4YRIv1RqJ-ZXnemKjPtqj9aGLMMHKAowqI>
X-ME-Proxy-Cause: dmFkZTEttKDE3+/h+V8bXrrHCjjVYmCqwH1JU1qzxvfwarY5xLheHdEXN3D1Mh82zFLmi6
    nkxNdSX/ANq5QxXfwBmZ20JP7Il0eQSi7zphRIfTEpIThVSD3DlpkAODcsOqOmwUy7Mpkh
    MxsW1HVIuM9awhoV2pdNirVaqs+Pyt+gRQbYH6pHNEInbi3pcTt5VMEJ0Zh0/qDeCIxmMm
    UwLB5nTRmne4Hyh3MEh+TAPxOWitoyu6DdeoPiZic7J8JZNQEqJW/ApHxqmGoXE0KG95Sd
    KsBkZi1jWKYPFL6ICt6OrKqVl7e+gH470HPbfadTSuBAYoObmN5oL8Eku5UECoXhHZqWXa
    Z421XD59QVjcucA5c2qiLyT2ht65NWfCvAs6uaU+CvgIC+n0qCrTcdfOMaTvo0uspJtCMD
    nzeNOTjMbbOmHBaXilEMh6CLO2ndmNMsI0TQHbdzZwmUAEoyzTr293b04gouu3LjRJgpu7
    iK/7fzaPKx+VadxfPbL2eCeICKz9m4rhe4IXz5PNuGlkZvw6WeL2IcnD2Om/Bo0dCrroLc
    F4/5tIg5Z/93yEToaoMvqQIwp0qfm0+naZ07bGa6jv4G4uorSWhOIvhSZ2TpAd99swChRS
    wjaMXDipXpmk+kq77EaHXr6P6gBQ7XsrnZMKc5If7iaMVnYUuN8RnqbzONQA
X-ME-Proxy: <xmx:8Ciwake8PF1wYXB6zfaTjre5uYFVorvgDi1WK01QbYPkDyOXu0LIZw>
    <xmx:8CiwaiHHXF4vqIghl0sww9nh0Oqk1nvMSMJT-WCWhIleg0JHihcQeQ>
    <xmx:8CiwaiiKn4jw9QqEmza9VZp-gpU1NjZUQXZSzgLBTol5w35bx-Lf6A>
    <xmx:8Ciwau0tH0wtxcQ4aCqPQpkGbR4Eo6DnYdfZokB2swd0aem_ojDbbQ>
    <xmx:8Ciwale1VhGd-4gX1P5vORckrFXdtOvpuwTrg7ZZfWL5zk-9zTkH69xc>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B329780070; Sun, 20 Sep 2026 14:41:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APFgRMTWF-ZZ
Date: Sun, 20 Sep 2026 14:41:24 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Ren Wei" <weir@nebusec.ai>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, sashiko-bot@kernel.org, rakukuip@gmail.com
Message-Id: <482ef2fa-b651-46f2-8721-8a2fe45e5599@slotpi15m67>
In-Reply-To: 
 <01a84794d26de3d9b78ccfb5f34025cd67429290.1789819174.git.rakukuip@gmail.com>
References: <cover.1789819174.git.rakukuip@gmail.com>
 <01a84794d26de3d9b78ccfb5f34025cd67429290.1789819174.git.rakukuip@gmail.com>
Subject: Re: [PATCH net 1/1] net/handshake: Protect request hash lookups
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 21, 2026 at 01:04:13AM +0800, Ren Wei wrote:
> Fix these races by introducing a kref reference count and rcu_head to
> struct handshake_req. handshake_req_hash_lookup() now safely acquires a
> reference using kref_get_unless_zero() under rcu_read_lock(). Likewise,
> handshake_req_next() acquires a reference under hn_lock, and callers
> release their references using handshake_req_put(). Releasing the final
> reference in handshake_req_put() frees the request via kfree_rcu().

Reviewed-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
