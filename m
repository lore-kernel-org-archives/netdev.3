Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77838E126;
	Wed,  7 Oct 2026 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415346; cv=none; b=aBI361C7+bBYN/pt7Ig3Yk3d/xm8MzijTTBFdf2BBhU+pkH1CQsx5y1Z/DcbtHyfxgoYIS6IADh3JfcDi6r8ygTi6zeW4Mk2MXuKfgVu8j5LIEp9C5RM036ItTLPA/k40XAOrEitkDK18KAYgyVAGvMgHiwXaujIyks2tPpE4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415346; c=relaxed/simple;
	bh=T+XgGCouqWyeejAZ+QB9EzFvLl90wS15UA8DGxcdXU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDtqo/wCGunqrDbULbl/9kyChBoHp0+Tlo5fAQNelxyJuHGO11esTzs2a938y7l9+qnP2fEsHVE0POMrIQBOCNTD04f4Wydvhglx5lYxLb1WUuIsM40PdZ2wLGJmKB/QnLLzv6Aiq2pqpHLxEYOV02/2+7G5F0z4iiLhizrgqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl5XrGw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl5XrGw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CD31F000FF;
	Wed,  7 Oct 2026 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415344;
	bh=RMeFJnMlfIuJqILm/Nb6Tk+8rOJGRsDm66e/mn9XIsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kl5XrGw9pq6zRCBSzf3XFP8Ibi2jHgovpg2LSeZcQ1+O6pCKWEqfI3oMZrGDuKHed
	 CO9KYtvEQfFTPYZ0eeNF7CFXq2ZmAhLTjzQDVKxc/ivXK5gWzBqVAtt5C00zc9jTVZ
	 1Fck8BsEBW5bCEm59RN9zY38o0pnMrCtwcdpOy+xZ3wQS0xx5VF38qNiHDAxN/Xpdr
	 YygX/7t5JIaBFA1truiSW0W57ogkxvB60sKV7DLv5fV/JcyMqjLPCIk0MGBFQNE5zT
	 trxJgO6BKbFOxn3s+nKh2XLM2OmVbY6QB+rb93eP0mMFGXZrBXZFNI2P87wj/C++V9
	 c9DNMXgqI6R2w==
Date: Wed, 7 Oct 2026 16:22:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pvalerio@redhat.com,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com,
 gregory.clement@bootlin.com, benoit.monin@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v10 1/8] net: macb: introduce macb_context
 struct for buffer management
Message-ID: <20261007162223.595dee2e@kernel.org>
In-Reply-To: <179115680422.434549.3193325311731249627@kernel.org>
References: <20261001-macb-context-v10-1-beb541bbb7df@bootlin.com>
	<179115680422.434549.3193325311731249627@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 04 Oct 2026 23:33:24 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The NAPI poll handlers read the context after
>   napi_complete_done(), and nothing stops that context from being freed=
=E2=80=A6

Looks legit at the surface. I was going to try to double check and
then realized the series no longer applies :S
--=20
pw-bot: cr
