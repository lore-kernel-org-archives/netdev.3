Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFC253B42;
	Mon, 29 Jun 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782772175; cv=none; b=BDGJFyZdCbo3tZu0G147Un2yHDnIGM0clTVbwidxRpIRSOdSEE6R1XcIA74kvVTgMJ8lFbTLHA9PI3JvQSCKXr7EnP9Jqmr1OYMzeYiRlX5afw4sg0COaUvGTaVpaKeSy6mKKOqGqsBg48edsdApz6vUgjBFgqM9bVDxMEXLYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782772175; c=relaxed/simple;
	bh=qy9IqYhxXGKd5+INDu43oHcD21WBEQTtF4OGoGLHMcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iliBd6Df/shVSltOtsh8Gafy6kZuGOmpb8IsZn/DbNeHRjq7CFUyDldI3TYMUEwd3GznGt3Z+bkE2b4iD9akwW4MMSXzwWcU+t4WHY4FGmN2P4+bODV1CXhAaFNuKd0aOYVbcKzw6gQOhN/Gfg6er83C9ThaL2D3ayH8DVCgLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAxJNYJX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAxJNYJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FF81F000E9;
	Mon, 29 Jun 2026 22:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782772173;
	bh=BNvTIvo405RKspjZMPp+9avnaKrNvmNbScCG2di6J6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZAxJNYJXtwhOSa5pxtT0ze8Ib8SG83A1gbK3Iz8/VE+oKhN3ZVrwMkQbtarYV0WP/
	 g0tivZDwOd2Pv+i7ees0T0yrzOZTzgRMJE5Ye5supcXnFDayEic3pOBU32NKkMeIvi
	 Rf6NJjjv14yPkD13Kga9Ow7e8deyJDYUGgFND1ItMDAcfC3bR8aU42hYoDDNIl5O3k
	 r+ua2Wj+1zZYFzTKbznYAdHz+aUE6Vsjy4myC/Ks+f/AKsywl1C/W5fXkq0R6rMkw7
	 sF+EaPpsGL3fYKeD8m26wLxl+Gg+YTg7fT7n6KKllIuseBwp9eCZ02DT+4PNi7VNKW
	 IhZ+RK1W4pw2Q==
Date: Mon, 29 Jun 2026 15:29:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, federico.vaga@vaga.pv.it,
 carlos.bilbao@kernel.org, avadhut.naik@amd.com, alexs@kernel.org,
 si.yanteng@linux.dev, dzm91@hust.edu.cn, 2023002089@link.tyut.edu.cn,
 tsbogend@alpha.franken.de, dsahern@kernel.org, jani.nikula@intel.com,
 mchehab+huawei@kernel.org, gregkh@linuxfoundation.org, tytso@mit.edu,
 herbert@gondor.apana.org.au, ebiggers@kernel.org, johannes.berg@intel.com,
 geert@linux-m68k.org, pablo@netfilter.org, tglx@kernel.org,
 mashiro.chen@mailbox.org, mingo@kernel.org, dqfext@gmail.com,
 jreuter@yaina.de, sdf@fomichev.me, pkshih@realtek.com,
 enelsonmoore@gmail.com, mkl@pengutronix.de, toke@toke.dk, kees@kernel.org,
 crossd@gmail.com, jlayton@kernel.org, wangliang74@huawei.com,
 aha310510@gmail.com, takamitz@amazon.co.jp, kuniyu@google.com,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
Message-ID: <20260629152930.4c2131ed@kernel.org>
In-Reply-To: <8458cf47-43f3-4328-bc6a-9aac31f1acf4@kernel.org>
References: <20260421021824.1293976-1-kuba@kernel.org>
	<0883a8e0-e8b4-4f22-bfc6-dd4a0fcf8b7a@kernel.org>
	<8458cf47-43f3-4328-bc6a-9aac31f1acf4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 07:24:51 +0200 Jiri Slaby wrote:
> And net-tools are broken by the uapi/linux/rose.h removal:
>    rose.c:39:10: fatal error: linux/rose.h: No such file or directory
> at:
> https://github.com/ecki/net-tools/blob/2ab3c5efdb5c220bc9a649fded56c361136bff1a/lib/rose.c#L39

Looks like the code for rose is already well separated from the rest.
Should we just ask net-tools to delete it? Or do you feel strongly
about restoring the now-defunct header?
