Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A023BD02;
	Fri, 14 Aug 2026 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671694; cv=none; b=FQlZie0Hbnq46M8yEQCwPlpx9tmmv7HCfSRaxXjyTB7nU7Dk+3YB9LK0uRFUJDc7D4mgoE5eWamHpWnB6Ms3G8AmR/uScXL43QxppwU6sLdh6KMKnia1/PgwRTut8SLpF1dSXsixu0tCXnEws8Wa8/Dj8YGKUYFQBHYPfMA6A+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671694; c=relaxed/simple;
	bh=8iPGc8+Wop++VVnWteUR4D9KZr7XZEM9oQs4x5WKcEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRMNJ3zGbe5AGEcirzO1QRTZ2N6mpFVdb1oBMn5b/sG+FDt9YGIl/q8PGYdu74HG1Bq15edTlKM8kXvbz54ZBLT9xyb4NdwmyKR9Q7UZg7Bem4JNQMvPPdHr4oX3BP8rURmBCJYnTcNgwZCmzhKZIivC02+SlvJikLkqKnsUoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8huJiN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8huJiN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247CC1F000E9;
	Fri, 14 Aug 2026 01:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671693;
	bh=Te9LLOd6PC6CliqhK9D9974DLK1VgTw2bgiFJB31U5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I8huJiN4Y0y8r3kpTPsJaiqiuIHJ8IvThtBKAK43x8aFpU1PFa1QXQI2RzO1TmtYZ
	 VTVJnX2tIeym+wbXnsawsnqITFkJzszMsbLQn/9vhgBiADt7TT2Fd/e+lGNkqmqcRO
	 HUgs9lAatLCy68sk9aOP9JSLtDtjdkkrdj+IvT1Oj3DzsgH2WxMlbpoP4Ht8dZpA4b
	 ceVYbQBvTr2HCCr7jmGTwtkiPCpsXMyb66jlX+sqDbxF9aZAO/+AKPLFSoHANxUnQF
	 EtR4AyukCPKPaLjAHsM4qUz28DR4dXrj30IUCZxwudbqJc6kwf1JZZdo0vjyMjUqJq
	 r844JMoiGzmjQ==
Date: Thu, 13 Aug 2026 18:41:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Wang Zhan <wang.zhan@smartx.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, keyong.sun@smartx.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] openvswitch: enable ops lock for internal
 ports
Message-ID: <20260813184132.6493b452@kernel.org>
In-Reply-To: <9f1d9db6-a39d-4c3b-aa94-9a70e979ce71@ovn.org>
References: <20260812123003.3634034-1-wang.zhan@smartx.com>
	<20260812164156.6bde8f4e@kernel.org>
	<20260813074007.3669651-1-wang.zhan@smartx.com>
	<9f1d9db6-a39d-4c3b-aa94-9a70e979ce71@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 19:55:27 +0200 Ilya Maximets wrote:
> On 8/13/26 9:40 AM, Wang Zhan wrote:
> >> Why are you sending this patch? Do you have an actual real life need
> >> for unlocked get_drvinfo??  
> > 
> > Yes. The use case is broader than unlocked get_drvinfo.
> > 
> > We are trying to reduce cases where ovs-vswitchd gets blocked waiting for
> > the global RTNL lock. In production we saw ovs-vswitchd repeatedly report
> > "Unreasonably long" poll intervals. Tracing showed one OVS operation waiting
> > about 500 ms for RTNL while node-exporter was collecting the speed of an
> > mlx5 interface. The node-exporter process was CPU quota throttled, which
> > stretched that RTNL hold time; mlx5 can make this easier to hit because some
> > queries go through firmware/mailbox paths.  
> 
> I'd say this is more indicative of the issues in other places, like mlx5
> driver.  IIRC, it can call synchronize_net under rtnl many times in a row
> causing any other application that needs rtnl to stall.  We've seen this
> behavior blocking OVS in ovn-kubernetes setups many times in the past few
> years and it needs to be addressed in the driver.

FWIW mlx5 slowness is in fact the reason for unlocked ethtool ops to
exist in the first place. So if that was the cause of initial backup
the problem may already be solved "at the source", so to speak.
