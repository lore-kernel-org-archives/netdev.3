Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC972C3245;
	Mon, 17 Aug 2026 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009753; cv=none; b=j7a7CEnojypPGxo0cpH1MZDb1D8dsge5KeyMypovRBQDsljv2OYrKvwQK0f6cbzwgUdDRQfaukRO+dg6UKBI+gadFGYeu5/WSaMOEr62c4MFvFc/+8BcOVomO0plK6dzV4v7RBfelWljq0diQ/9RqIPrfhCP2ZSzzYSEF8x2MWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009753; c=relaxed/simple;
	bh=2hjBe+6fg1kUWNMVSs9m6I8gC1xQ9hXKURnAJaLTGb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwMdCtlIl4moQvg8GIRVENej/+3IAB8jyQh+ulep2N3KA/zbtWrCjeQZ5viawI8B4Ft17YB2hp4TX/Nlw31wI0mejqklHvjatq+PXZlozlnn5BzhwfsgTro/HDoga/qXmXVXMz9Gw2dPkpPcbQdvLizUbIyCiGXLHOkp6IhWgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVgPouH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVgPouH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3361F1F000E9;
	Mon, 17 Aug 2026 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009752;
	bh=deggn4EACIgb1Na3knJx1I9cD+CWY64Le9geMJuUaXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WVgPouH8fPfZnz//YzyNY7/EtFGEn25JHdxNJ9qDv3iS1dM6a1BgUo5vTDzXffBmF
	 CnG5E8vjamUHgu83qTcyyuhxxychP9R/CTcXTTh4SiKWcKy1vvOo4OXiHHeilnil7V
	 ifWzZo2YVmYxzRlSdtC88g0+X+jC/il7/G2tz1ll6+sJZVY9AwOycNPbXPMt/kjxwA
	 6w3TAE6Vat6ynIAUH7i7D/RxiSNu/TZRYTU5ahtf1RczLnyjSK5hJLnWyiSkQvDWUE
	 nnJovR/OXvz+deMeBQui6akxDehgfZ/UlF6xMXpbfCueXHHQQLCm579SMSkZ4xPBpE
	 EPTJOWR/Jk9+w==
Date: Mon, 17 Aug 2026 16:35:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 08/11] bnge: add NTUPLE filter infrastructure
Message-ID: <20260817163551.5eecb007@kernel.org>
In-Reply-To: <20260814011435.194631-9-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
	<20260814011435.194631-9-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 06:44:32 +0530 Vikas Gupta wrote:
> Add the core NTUPLE filter data structures and firmware command
> wrappers needed for flow rule management.
> This helps further patches implement user-created NTUPLE rules
> as well as rules via kernel flow steering.

transient warning:

drivers/net/ethernet/broadcom/bnge/bnge_resc.c:633:23: warning: variable 'hw_resc' set but not used [-Wunused-but-set-variable]
  633 |         struct bnge_hw_resc *hw_resc;
      |                              ^
-- 
pw-bot: cr
