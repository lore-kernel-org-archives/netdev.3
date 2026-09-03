Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4414FC8EB;
	Thu,  3 Sep 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458239; cv=none; b=BVj2/npRI0s4ixi/LQ4Ztv8sS583ptuMlGVbuwqe3gDoKCIEnM9qYKs0fu5TsYmq04s1uv82dZZeEl7vI/hyGCEaeuoK/WkRe8tBtJvWJNAi1jcNb/gteZW920sw6LR/4b0EariDGjkF3rg7ZTG5VFCmuJF6Ew/LZxTQRjAflDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458239; c=relaxed/simple;
	bh=3C5q+FfFUjSQPHAIrkGd1W6Mhz6H0x0ruaNven2JREc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnFZoNvYOThQPHJwipmP7jNtD57zejBO5OV2YYIgV563JlE2AnzArOHSy8Uw0IC+6U6VlNQsl5u1rZPXzNurR+uXb47HP78+uKSo4GW6iFwMU3jaulUjDDPh8BYnbEbqUicehnuu1UCMK4qNMCphWZSLhiGXNSPj65nZ5FIvRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS/ABNXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS/ABNXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AACB1F000E9;
	Thu,  3 Sep 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788458238;
	bh=3EWQPWKg7sfms1mg1X9s670G/ih2iu5XcrsXL4FiDco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cS/ABNXEL+Tfq8F/jtZolacIb5ZGIWaNHTZUIahubFBsektM2lTQikMt0QBjduaVE
	 aYsoJbCLe0atJGuHgDZDg1oV1EzZGWqPmx6tQq461//36bzM0LC1QT9GPSd83lPT/A
	 j92efWWzfQ2hw5p3lD4wF2nuVs3EYYKkHP2FMfIkFg1GQyqCfBcFsgE49ezwX7wJSq
	 vOGMt0tA+0nmbrYoSfNSMOAw/FLEr6/+fIqe9C81ImMeXUfvE3xVO1LY277BNyYIyP
	 nUz0AaDbndE9Ti5XdAKWaduWBiqSqNfxuGKQqCwO7CIJTGHmHbIHJ6xTFxQmfhUUPV
	 /k1kPRrCpZULQ==
Date: Thu, 3 Sep 2026 10:57:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v12 0/5] net: dsa: motorcomm: Add LED support
Message-ID: <20260903105716.5c163da2@kernel.org>
In-Reply-To: <178840621563.3072235.4183497708325455365.git-patchwork-notify@kernel.org>
References: <20260903031630.356840-1-mmyangfl@gmail.com>
	<178840621563.3072235.4183497708325455365.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Sep 2026 03:30:15 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [net-next,v12,4/5] net: dsa: motorcomm: Add LED support
>     (no matching commit)

Sigh, I thought you said all the issues on v11 were false positives.
I merged v11, please send an incremental fix.
