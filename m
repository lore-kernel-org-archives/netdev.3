Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBE29D264;
	Wed,  5 Aug 2026 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895713; cv=none; b=nM+6Qic9qPCf6XWBmUUDG4ZuwqqgfyaYZmX4GmO+UGImtlMgHypnFeMMYEp8Z5Xybx8AEP7AwJJOlWHAvfmI9ZmHAVp4eX2+2/cf7Dgfm6FTUFPJj2/Rrxg2r8XDSzsi0ImbFAoyymD0E4iLlx7PV+Yid75WJMcXBJGZXJzyQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895713; c=relaxed/simple;
	bh=Ucz/9OkeLUo7dHWKbHJy/6MgTH9MttyBodnwtTFa3hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgrKSQe2sVSvAPPy7w1bx2UrxC5K3akp9DztMGoGOS2AhLSD1U59x5kMnBqrstZHZVunA58Eu6z5GlLxX6MOwCCY6nqHbKVB1J0eGcDtwmkjOjWK2r/6mHgcfZL13DBIo1OVuz1VGgnc/QERE4kXzlaIPOY71mGxzG5p2snGj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfS38Q0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfS38Q0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA2B1F00A3A;
	Wed,  5 Aug 2026 02:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895706;
	bh=Ucz/9OkeLUo7dHWKbHJy/6MgTH9MttyBodnwtTFa3hY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EfS38Q0iuIlcI5k2Q5JK5Lsf5oFTNbpI5Lr4kx2mJuhJiv+N53h4U/W19X/rHl/VM
	 UK65Dy3jZUPWKo7qc+KZ443A7Fr0CK1MJqyMYi7MZfoNgydOqmrxeFcEapdT6nQn97
	 8Irb4bI5unrBy9sd4Rc0qCVIEws8dv245Lo8Aqo1ccFLLe8x1QTFEkvuuWwM6socSS
	 38zl/AIHX9eWzcgoo4qzYjEyKtziFFKxlczJga11wwE9aZtnk2V6IWp/Np+vo08KRc
	 JTvTeWBFy3+BNG7B8TE6CovyxKhEcugQTKbMpW4PSwSTJF7VsFsEoA6qk++ED3U7+k
	 ArPET+OUQBpUQ==
Message-ID: <9c1e0622-024b-4443-8fd7-8e76a024da14@kernel.org>
Date: Tue, 4 Aug 2026 20:08:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vrf: check register_netdevice_notifier() error
 in vrf_init_module()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Minhong He <heminhong@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260803090002.142453-1-heminhong@kylinos.cn>
 <f8b967f3-238e-4402-89a3-95d8ac0bbe3f@kernel.org>
 <20260804185504.270ab5e7@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260804185504.270ab5e7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 7:55 PM, Jakub Kicinski wrote:
> In this case I'm going to skip and take this via net-next
> 'cause register_netdevice_notifier() is guaranteed not
> to fail today.

considered that response, so it works for me.
