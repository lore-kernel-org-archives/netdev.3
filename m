Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79A1EEA31
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243407; cv=none; b=DttC94xiR5qwgoLdfRcYqHaxhONBw4rs6yi0SdGOO/lvtJOs4CLQn9OfeENje3VPn0xydK81bvlVNUKusXhUifZigZ1AcKJnWpH52mneHsVbFHILogkPoMidGZ6e6yhMxSVcUel2wScnKADo6bNjb/jPN04TFKCh9qtnFwYFcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243407; c=relaxed/simple;
	bh=BGWLV9+w9nR7PiMap6Fodj7LzIm0uAU/oJ/R8pJg9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXx4URCCTiO8F68o+lyfOFksVe/NTZV/nannd5S5cYWLY3ykRllYkHT0XX+mtxf4MBpMtP9tmlgENTpb3KBzr2v9JtULAxex/pFnQK+UCBbMBUZ+uH1fsEdZAF0XLNlXlP8VVIu4NmIpshmzYLqwUttWSfUdz/XNyvuRosha2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5p9nc7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5p9nc7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC9E1F000E9;
	Wed, 20 May 2026 02:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779243405;
	bh=48dGd7TuexNPOpbU/56cBJu++0VZeI31xrsIpWgmq/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W5p9nc7WLh81mmrh5WYIAhCRBo/alZdJc7eSJqUFRC6vUvX6MQabGfgAI2QPYhCOn
	 JkJ6UNSk+9BBaaL4L/07w7D3Q+5XdvCne/BxFDLcpBgqVTjS/zZZ0hu6aobd1r6PeC
	 Dqf1Buw/qmr+1ytOcC9+iDKt0JjG3u19hwNO0vYqwUrJvJ19RqawZGEyAdV86X8HRI
	 93wlv5w9c7qPt3PQKQp9bE2Equ7oWYp4Ml+y0NAO1s+BkyTULpi4vrc/8+67jvjE3B
	 Pt+2P51uAKo/NxYG/GJoE+IJ55FoLMJdnoD5zJDlwBZ/ffVXUlkUVAWCfMkf81KAVs
	 ltO9TJWXQ4VLQ==
Date: Tue, 19 May 2026 19:16:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: <netdev@vger.kernel.org>, <brett.creeley@amd.com>,
 <eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net] pds_core: fix potential stack info leak in firmware
 version reporting
Message-ID: <20260519191644.1574c9c8@kernel.org>
In-Reply-To: <20260515212907.998028-2-nikhil.rao@amd.com>
References: <20260515212907.998028-2-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 21:29:06 +0000 Nikhil P. Rao wrote:
> The fw_version field in pds_core_fw_name_info is a fixed 32-byte array
> that may not be null-terminated if firmware writes exactly 32
> characters. When passed to devlink_info_version_stored_put(), this
> could cause a read beyond the array boundary, potentially leaking
> stack contents to userspace or causing a crash if the read crosses
> into an unmapped page.
> 
> Null-terminate the firmware version string in place before passing it
> to the devlink API.

This loses the last, presumably meaningful character of the FW version.
Are you saying that device should never send names this long and this
is defensive? Otherwise we could trivially memcpy() the name into a
buffer on the stack that has one extra byte.

Please fix or clarify the commit msg.
-- 
pw-bot: cr
