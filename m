Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C138F941;
	Sat, 10 Oct 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791668421; cv=none; b=sbF1X14UX9EmEqD/miXrGq5A7iBelEhDqZkBKBU7tfJJ07JG28Kgt/er8bOqKXU8zB+Oc8/0+B+Y4ovBxLcjt6w+txIeG0glidI60WavSrhz/ATMPomtyrlFlGVO2J0v0s32ZG2A4wqaMWJbGQjzn2Kozay1QBtWfUUWdVy/Z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791668421; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8Rde4TnkIqS8blXX5Jtpe74h7iBKRV9BwwU1KOx/6MaF1XWdPwpxAY9kc9NC37BtWzMVAvvGThHiozfN7oOdHGJCX+/az5xD0PPvu9HNoNgS8bWE1OHYf+zQsv2M20AscCs6TIfFqyrAq81e9zHZoyqP9o/aum5NIV789GDFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axg/SzNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axg/SzNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35711F000FF;
	Sat, 10 Oct 2026 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791668420;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=axg/SzNKFFAAkUWhRL9uUquNYYiVXI1xOECF42dy7zZMZVL8AKUsX+f/q7IL+HeWR
	 imjJfpdC5TYiPLxjKM5l5OMQApJKW9eKefMddSVrF/XGKNKw0pQlNAoP9+Cj9kevLT
	 LSSsLwelsAWAhphoCN2pAYEfe4M/nb1hDjLUPg3Cu346UKVk4WtwoR/ctH++7/e0pT
	 eqcTm8cBBpAKB9mVs9nheNvXGf92fRn7fH0//9gYouTOY458k8eZ/qfC1vuf3gKt3z
	 z7NvsHrc0vCAtEsYL6DU8hD9KnETedfzEzg1xPrxRMib/EPd56j4BgpsMm4FMntajM
	 mFVpaQkXGFJ8w==
From: netdev-bot+sinfo@kernel.org
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nisar Sayed <Nisar.Sayed@microchip.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: usb: lan78xx: reject invalid EEPROM write requests
Date: Sat, 10 Oct 2026 21:40:19 +0000
Message-ID: <179166841946.2527009.10226550251480209006@kernel.org>
In-Reply-To: <20261010213248.15938-1-stefanomunari.sm@gmail.com>
References: <20261010213248.15938-1-stefanomunari.sm@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
