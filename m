Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018939903E;
	Sat, 30 May 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131606; cv=none; b=ljx4nqRh4BzMa/x9LxDE0cDa1SBBeiz+JbJypkwGGcrvAHcdwAhIL6dzzFx16s4YaW5QDS0stdgScns4tLtuYADOsxOcZ+4VfJptxHS5I8buWJRC93hSK8nswueBq1V0sEX20QGnXcHS+OF3yrUWObZj59mwQ9Ik1vEroS2B900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131606; c=relaxed/simple;
	bh=MvjbpLL71y4+zQOMwBan4Qo2vQ2xV2sLjWehOAPUvU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ/KuAUsxMn+3Vw+PaEWsip18bKkZkCjc7ELnANiFjBzhfM0h4/cjlF50Snv9MHnaH3EAGDIPSQkg6Ymlf0XA4Spl5UuTTLjqemxKkV42LcjGrlCE6Cn1cZGKzhy72xMpd9sVOE3ogmVqYygGJLh5MhXsy5g9OCYtSVnZQ1sjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdU6//Z+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdU6//Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7211F00893;
	Sat, 30 May 2026 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131605;
	bh=tCkX3zxuOePO0xgl/G8aJ7qh6MFUTVrX80ZM3bIG+OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GdU6//Z+InKdr3nS5pCmM0VXPaeXMoPCJGpasxqDehk4RXaOch2MjM+Oqxm24yL2s
	 R73IgTCRm3kwkkt4a0Y7Lv1gsJza8WgaSfne+tdu55hBTffBh7h5qH5yLTgv5YThUf
	 pSrNz/A9Uq5xqRtoxUbCF9vJRn/kWKjViAQHTLjDugd4CX/qN2pCn/KIRPwdEt11WH
	 k01M2Oe1ivhaL3RPXjTMYr1IrbOJa16MWmo51agXg5nnOAszJ8f3v3YppioITOKSnm
	 AVNHLVSNcKfXtJ7Nyp8UyHn67/Kk+9BjKm0LsD+CSsR0CG2FmGqelwwUXXysm1YpSq
	 Fe2clWneEKoBQ==
Date: Sat, 30 May 2026 11:00:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Message-ID: <20260530-adventurous-venerable-buffalo-edd6d4@quoll>
References: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:41:35PM +0000, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg
> compliant Ethernet transceiver device.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  .../devicetree/bindings/net/onnn,s2500.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/onnn,s2500.yaml

Where is the rest of patches? Where is any changelog or cover letter? I
downloaded entire thread and there is nothing.

Best regards,
Krzysztof

