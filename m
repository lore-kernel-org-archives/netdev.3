Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC137D13D;
	Sun, 29 Mar 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805710; cv=none; b=SGcsD/Xh5na7Nm2AqXzryXIK71RF5i7j/tEYTKnYwj1JgXpfuJ+vPsMitRobJjXK3I0U8ut6H1L26dYyDjPY7joL5ZR1YicNBIr1hgib6x/URyQBITm+7U7wa1rffB4CPPbVDMhmtpV0NLK3qvCgoZt/mTHMWduppN6ers19w+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805710; c=relaxed/simple;
	bh=3iL3RlZmKYo5TwGusufQHV14YikV9j/wPb2l6HWvCro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP/gKsBMf0yLrtLlsseslUjbRA22YZv0YUwlXbIqKcmOJO51QZB+6sVEseStRBIYUeO4m+RIc44ykTAyV9xQIzZvDULhsS9Jv/mAqzW2EqO4b+xIvbJYgu5kgFhTLrjeHN25uoXNlI6Z07UOMCPbJeoTI17OlxFcJwdylbHqbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqJ1f1ca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqJ1f1ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F37C116C6;
	Sun, 29 Mar 2026 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774805709;
	bh=3iL3RlZmKYo5TwGusufQHV14YikV9j/wPb2l6HWvCro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UqJ1f1caBANTOH0w9MpM1yZY8r+MFjpghjqRv0DHKfWIo/WY22/oIyFo9s6eFeG4S
	 8gNcIU9Du+ZCof5ZXov0PwiuzBEgpGqkCqBVkoUw4dZVSAQkztaZVDm/j+LRbpbTyG
	 0MD3GoEseDhY4RUfa0dfe4ax8VYr5U1GGO5xXmZ5+qlVsrd/9S+82AyFfUUJk3N40C
	 nlofk16qK6cIfpXXBUxX4G8tFuCxCUH46cMxagAIZoRCo8KANGj5wkFFWTHvWl/A/p
	 wS3jfUjUjFvKDPwdSls/9tyTGOAjcSya1a60ZRXGSIVDNdkPjaG2qDywemLJLOzUk9
	 aZ7MObTMmDA7A==
Date: Sun, 29 Mar 2026 10:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] hamradio: mkiss: modernize and clean up mkiss
 driver
Message-ID: <20260329103508.4905cc09@kernel.org>
In-Reply-To: <20260329143408.747197-1-mashiro.chen@mailbox.org>
References: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Mar 2026 22:34:03 +0800 Mashiro Chen wrote:
> This patch series modernizes the mkiss driver, which is used for
> AX.25 communication over serial lines.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject
