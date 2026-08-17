Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817043E079;
	Mon, 17 Aug 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981470; cv=none; b=qzZZEdHSeZY05Iua863WJRZhM4uBg0o8vJsyQaqH8gzEHwb1treguMqnto14DEaJEUxh9ipOZwnIYiEd9gFHl/BIruBHoYWRN0IYs33eHkA+P182xOfB5yihIi4yQeteMRS1la6G4qvytLt9SmqFupW77tcu+MmdTj7clGhVc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981470; c=relaxed/simple;
	bh=2nLQkUyEKRR18p+WnC9W2wgWKyl+84bDXBYzTf3PfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiqAlIj+0GjDvB54/99sPRIF7sQcbKfqQM0I7nk12pbkAdUPhxgHZftZqKNTf1BDvURqJIGiUYETyjvx9Cp5tKiOthIZ4VW71SgiGN1qxES3kaE9NyhcFAOnYg14hTJODEN2N9FFcJcYZnKVMH4ERCMnx18R46FngyZkwztw4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLjgiJvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLjgiJvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748051F000E9;
	Mon, 17 Aug 2026 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981469;
	bh=ALW69sobqjQmXlkf4i60Ji/sF0wUVgqZ8KQ8cjh+01w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bLjgiJvrF7JxqPLdAD+CnPP7txks2Xv27Qc+igBF76jTRlynkD3q20tik3RXSMTar
	 xnj8PSqlxNjYUCL61X9AVaHp3WcuQcjgDPHUHULZff8iQfs5POpQamVMzTaCecb0AZ
	 oZjBfIuW8RxxlX9ChxO6jSVlSjoPdEpMy6nym7Hr6HrQjaMdYTVinN/3/lrtnJjm+g
	 s3RH3qve73pezBRAWo1gR5INxMgbtg7i2cSpb5QKaRARydyloLLWg9ZbgwlaYEeQj2
	 W8QFuDaR3uCA7GgymZNgs2tpKxQtEhE496GET9ATzahtwDA9vco4ZkK1zo4eu0a0qJ
	 8oALL4ZqJjAzQ==
Date: Mon, 17 Aug 2026 08:44:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v12 0/6] net: dsa: mxl862xx: devlink flash and
 rescue
Message-ID: <20260817084427.54db3449@kernel.org>
In-Reply-To: <cover.1786922210.git.daniel@makrotopia.org>
References: <cover.1786922210.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 00:23:06 +0100 Daniel Golle wrote:
> Subject: [PATCH net-next v12 0/6] net: dsa: mxl862xx: devlink flash and rescue

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

