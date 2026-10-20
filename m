Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528486;
	b=zVMHPQeyuPAtUK14pjUhhSzQCXUbzcDMxm15TZqoOciPe8I1aYTaGUQBS4imB0zsvODi
	 WLSvJEa3B2omwCQ5UMSn0toRY7Bjpuiwu9nTy328YWJ+KjG0jI5SrDj8PxgxY8MkL+ciq
	 /gChtbK75hzQZJf1W7LUXp6sr8Vead2o0MFj5hc0z3+xPupIh9nwH4IAnTmo7FkEYp9nB
	 +AGsm+sfjYbM4pJt/HrvYTsALOazUsy794WrVKHT2QVwdNHrc6okqzjM3g8gunMdKsV7s
	 sVSNYU+MsSk0I9urCC/4MrL06UdHyZN3rV5B+QJirZ78kAjP0JlQWs9pj4phbh7btKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528486;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O4ssWf9mPwzFD/vOFS0ydL59N5Jw/IIth11ALEy8fqA=;
	b=0hV6PPE5RDCMeiO5RbhWuPE86WT+NVKudwOOegiH+McmJR7Fi/O50h/73SI978MwdXQL
	 8uctuJu2q4BBfKBK6CJasIMikJLrf59cFu27eUWJMfa6QajBmXKrOtp+vzepazliGXq0s
	 ZV/IKDVRcLUcvr8YzDddNitqk6MNLrwWEM2vALZWrH0bv5m3rULrqff43+5kvk9dKeeDT
	 DbezO/aMjcNsUKh3tW65Gm0qDyDX7wGBbyKzRszNNhfIXjV+NV5sdc1kqcclnMcl9GdtQ
	 ohdd1b/micTs1rTt0ifEaMpdbYkGjcv6USKl/Mxgk9MwAhXU45hW0n3VYpvCJkFvr9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PECMHDer;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C38606A319;
	Tue, 20 Oct 2026 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PECMHDer
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA11F000C9;
	Tue, 20 Oct 2026 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528485;
	bh=O4ssWf9mPwzFD/vOFS0ydL59N5Jw/IIth11ALEy8fqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PECMHDerYPhfsqzwFL6HszqczvA7pEc2qIFewtOs08m4m/cQblAeb7exgS4fa4yOD
	 1B98hQK3145lEZhPfljS1AV3olSXYnrcsnmilnRyIenPmo5dCiNRyGexLhnZQAM9mc
	 TI/uTnaD/CnIhmHqW5gh04107Y0WVQ4kcGOjSFQ8r5BYyJB3asmSVay7cyYWnjfb+B
	 ZFFJO+9ImfE4aruJWgPJacRqE+6ik/dY8KG3xDiqDKVOsjB40gRLGT7tH3r1Z4V+AI
	 kMjRfQ3UrgMdq4mHR5IE1qeBJuj+B5mYnwH1wkCvJE4+9nywtUyVoMtbHnJtADW8tA
	 TD+Pru4GImG2g==
Date: Tue, 20 Oct 2026 13:34:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Dharmender Garg <dharmender.garg@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, Ramakrishna Koduri
 <ramakrishna.koduri@broadcom.com>
Subject: Re: [PATCH net-next v3 5/5] bnge: make NQ0 persistent across
 open/stop cycles
Message-ID: <20261020133444.3395670e@kernel.org>
In-Reply-To: <20261013200645.1346299-6-bhargava.marreddy@broadcom.com>
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
	<20261013200645.1346299-6-bhargava.marreddy@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 01:36:45 +0530 Bhargava Marreddy wrote:
> NQ0's NAPI keeps running while the interface is down

Sounds like abuse of netdev infra. Creative reuse of this sort makes it
extremely painful to add stack-level features.
-- 
pw-bot: cr
