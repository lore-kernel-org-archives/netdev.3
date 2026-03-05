Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D433C53A;
	Thu,  5 Mar 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724109; cv=none; b=XNWuSxO90xkkMZ26bEHrH5PLuVNazNCj3h5GWTaz2gRcxkiY99ruHQHj7HT7PSxefCNhgDKF9cKWaxv3j9C6zxyfJLuKwRM7WoG3Qt06HIrmDZzSlwvp2g5fBMnVHpXEOuS4yzQs3RrSGz9iIf8bIGkrkuh1E732lHMTGkbxD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724109; c=relaxed/simple;
	bh=Ko+d+6D5NOJWl3qoXrPZwe0PpbdIedfPT4KtLsRg8zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTeVg7Za+/J5EC+45gAClpRiPwoNMyrDgdwJMpq2IY2vAg4BS16wdW1TL5TV4cHUOSt+gUEHbmPjg1hO1pPiW3b0Sbu+cJQptfr9I5ZETS0/z8TO8oP1EFy54x0Z2H3mn5DxIDiSiOjjsqd7/HzlVrogeQ+X6yvZ/xuUtUpsIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBOFcs/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBOFcs/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD75C19423;
	Thu,  5 Mar 2026 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724108;
	bh=Ko+d+6D5NOJWl3qoXrPZwe0PpbdIedfPT4KtLsRg8zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBOFcs/NmzcJQhsGghr+1qQQTA0L4ZZRY1JOSUzFSfmfqle457RysvyW99I0iWS0Y
	 CQWxllE/lR1tqsgI/p/bHZ4YUCeKfX3ARLd2qN2qChEfX0VIdEdIfhyqifi21Ujte1
	 dy9bxXuv9GdFjUTx4oG51rV2uf6Twkh0o7oo8gIK53l8Ai+k3HgfDfSak0haBYIlPg
	 V3rQ86sjrhOs/W+iXUPUvlxQjIUW3kNpel3oXh7zh5K46TJfJFcHYyj0AEgm7lWRCs
	 hB3iOpeb2uN7Gf93xBxsxOnSxYClx5s+dS3kZzWGMslB1RzXa3iBeJ/1WPKQY1tuFG
	 7PlJS0pQWUyBg==
Date: Thu, 5 Mar 2026 07:21:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mnhagan88@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: sfp: improve Huawei MA5671a fixup
Message-ID: <20260305072147.102d9d43@kernel.org>
In-Reply-To: <20260305125235.51286-1-noltari@gmail.com>
References: <20260305125235.51286-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  5 Mar 2026 13:50:32 +0100 =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAULT
> signal, but we also need to apply sfp_fixup_ignore_los() in order to be
> able to communicate with the module even if the fiber isn't connected for
> configuration purposes.
> This is needed for all the MA5671a firmwares, excluding the FS modded
> firmware.

Also please don't repost things more than once in a 24h period per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Andrew could have given you the same feedback on v1 :/
