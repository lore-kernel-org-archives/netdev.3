Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D23B5822;
	Thu,  5 Mar 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722757; cv=none; b=k+Ss8vPEdJlHFR45HElucc9Tbnxn64bX3TJ/t3XHd82mpAr7DY0AOwD4A+F2s3A34dTJR9mOxJY0RmG56G8Y0rO/ZyDr9Vfgwbe5kCRXSXVY7z3n7sV2q7Jwo2P/mnW7nfV1+/yKOiL6MdwFR8ZwWFOywhAah4nLi8KykRT1+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722757; c=relaxed/simple;
	bh=3gau5pG01KTTt4gEFZecCxSVw0aAS8XD2UN3kTCjwq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NidPCQNpgnFcjcfBvBRGwF7/KUhmKI51armrf700f0xZaqauupzKlbRJ+8cefPEX6k4DbW7noMyGX2JN6SoMJbjcnrc9LswtHkTCimCtO80S7yLb4MS9gXEg1WajDhbJmYZgQw6Z/lmAxFInG9VAKXBSvJJtR/KZbK+iZ57exS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kASKSyhP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kASKSyhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E96C116C6;
	Thu,  5 Mar 2026 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722757;
	bh=3gau5pG01KTTt4gEFZecCxSVw0aAS8XD2UN3kTCjwq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kASKSyhPP31lIWhcYosKNNj463+TUPNWIIAvUEtOMKaHvpbJELFjzINyZyXWlicwZ
	 9Npn1BaMu3UwcVwALDgmMC9qflHmKYallSokd27VgKjnCq7PvvOS5rharoLZ2eOt44
	 w295EATUFH4dMz145NYogmRWJShttctzhzdXtaAJr3R1D3SuBy5z8q/1iEzXIqI2QW
	 ADqPArN4JfTF0iC0/ROs90SaMoTnHeo6YVtGhHuQ7g0jg3TnXFStR+6AnDx9Yx7nQJ
	 G8LWNT5oGu6s7MjE2dEXg1uZHNuALubarlA/WrfO7VK8f3T9k5MZuaEbtRGGSWvd2+
	 K7IcJczmPQRaw==
Date: Thu, 5 Mar 2026 06:59:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
Message-ID: <20260305065915.1e6e3284@kernel.org>
In-Reply-To: <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
	<20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.270f71617ce0@gmail.com>
	<CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 16:24:05 +0530 Akhilesh Samineni wrote:
> The PSP supports dynamic administrative states, allowing it to be
> enabled or disabled during runtime. Currently, statistics are
> persistent across these state transitions, which can lead to baseline
> drift and complicate telemetry analysis.

Baseline drift? What _concrete_ use case do you actually have in mind?
Do you know of other stats that get reset when something is disabled 
in networking?
