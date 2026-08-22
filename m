Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD6248867;
	Sat, 22 Aug 2026 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432314; cv=none; b=aUzMVNIVRJ3TycXCfg1Z+jGwH96mjheyva0o2cXWogWXsygZ/3Fy4ObBXwJw2kD1K0vs15sENm+NmQHtBP2bYoV9aBLsom5+I9ZRxRMFcB9wd7saZovRPtmDCPPkoVGDsWJ1UC3gcoGSLfqzLH2iRNSc4RT+suhksp2rx4c4dFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432314; c=relaxed/simple;
	bh=+JvEFmYImkNM1oCM/ZoqAaNtVfVCWdbCW0OV0OsMvc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl0jSCI6LTUUVsos4JrLl75+lPf1m+IgydSn7ZHcCUhN4AD4smm+EVYN+COxfwKj0rYyaIsz1YUg4lA43gsJiUGCSTg0hWU0DFdx/BS+LfxEgTv3N2uAfA6cd3sEuLuEMf63Hkz5cmfcVzYiDmsfoUMT0dTu+mdtLyg1+CfVCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEP24lXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEP24lXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF121F000E9;
	Sat, 22 Aug 2026 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787432313;
	bh=mo6+8fDaipQUBMzpLUveWST1Lpt2rHGvpVRXUGH+I4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gEP24lXgMw3bZjuduRKYrg+hkHHFgKQ3DUeXKIQSP6cdEwuVvb01D2JjdYtdGfPnu
	 Sg1kj21uMNAj1tYqkPFyQSnGRKGd4Q75Oz6bNmi0tyWx4IcEDwcf/vnaOYuidXquvK
	 KwLmx6wwLIFMoA6sW8una1hv7E53KLE6coQPp6J5V0X9ITwCEf2ptxYTH+ya/svh8R
	 98jx2/mJo93PnZThtZOFbhDAjRG1CHEx9tf3wGIyDbBwLa4e0/Gah0UbdwhXTH2Pt+
	 73QkvHJuQeUhKHF6c1SPnPj5nV3Je07u07iLLwAgruD9HkWDJd5Tds5ymeOufP5UP5
	 h7xoodUrJWcrA==
Date: Sat, 22 Aug 2026 13:58:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Message-ID: <20260822135832.274fe2a4@kernel.org>
In-Reply-To: <46bc8a60-8979-4b0c-ba43-f99256561a48@auroraos.dev>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
	<46bc8a60-8979-4b0c-ba43-f99256561a48@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 23:26:30 +0300 Sergey Shtylyov wrote:
>    And of course I forgot [net-next] in the subject... :-)

And to check if it's open ;)
https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: defer
