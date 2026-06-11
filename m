Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DD2E7623
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153230; cv=none; b=CT6NvtVB0OXH29gGNtXm0Gln2A5/gluoHzTqVDLnHJzc3WJGddoP+Ew7Dhf7w0mqR0O4Z/6SVUqNR906fRxxWrZQ0Ez7iqgMQNYk2npiF2otqECldxc+qahWdQmvom+PhpU4t3RkNvOnWLfpHetiL9mJV9J3PLD34nh45vmnbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153230; c=relaxed/simple;
	bh=O61Tg0Oqh3pfDfsFlePc1PsNIV7fAA/3rddKRc0PUiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi9uQ62wtexOuK0d8GKL00pD3urSsxe8d/MM+PDdfCiWPHrYyXTiQD2PHuwyhKkizUH8pga8E2FRWiqbvIp/X5jpwEia0hWuLIxbl7JazGl22RJ2C9t4pTeSTRKDRu8SW/YjY8W9OzCiQ+1kvoFtvDTIhZPALOto4kVUiOontZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mp9F+2A6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mp9F+2A6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eeba68948so5374726f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781153227; x=1781758027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3h/y+lgDeExoFzO04Ifqt+k5R3DqbfaEHqy5rTGN4TI=;
        b=mp9F+2A62s7979OQdfpSd5ty9ZAIYr4nJqlyzLb1kwsFHKo44UffeXwozI837IqUfR
         FmJ3zNRL5mHuFMJadjfuAkaNkx5nIvFsJ2FTD1rbeDXjAH9q+t6ioBDXyIwDmOF+KMrH
         cOiQWBZs06GFpK+CZKTecfNi5V7osVpB6J2qNcxWTn2zW75bHf0cz5h7+iw4BCEOSFYg
         yAFi7/C6ui/wWSN1gRqYniVGwYHM2TTW6j8UuAEen4csj9vz6OjrCycfKYQCFNIqAj55
         L1v9mb8ZPqPY3a7Wz08jjA3dPj3DBCemo5VbNQ2iUIZnVtlRAAR38hwZTTaxkqudrqYB
         BGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781153227; x=1781758027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3h/y+lgDeExoFzO04Ifqt+k5R3DqbfaEHqy5rTGN4TI=;
        b=qhGKldQSlUFk5hbJwb8CKn9Px5yCR67FQCXVJQ39XuGnt8fCyLkA3yKZ4syA1ry4+7
         dObJqoISd9AiRxdrN0mesF+NZ0NRK3QWV7bzILIg6F05HKCWCxdwqM8mnMz8VYubunr2
         pWpCh8I6WUCFkK9eZTjvshhLYGWqSXZHTkiqGR/yJjwGlEOUYOp7aARPVfaanZUmbQW8
         pJjxehZGtt67Ow+OKzFjxz2xvFYHuqFJ6CZGNMuyIiB0T8aeXEFsw0xFpkZd4BPZzf9h
         gtRnPBN0zRjPUAUX5N6OS26r38hUD3h8J4gDPPvohTir6Z7s7eCxeaAsUmPFncoB4Yqq
         9eMQ==
X-Forwarded-Encrypted: i=1; AFNElJ94htMnC20/RCicLYkvH/v4j106XiudeeT46ahHc56ZtwAdefV8HbPmC0HavDwHZ7esq76fkAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx41VakqLdn4z7lUnEZtr5pV0n/pJM4pwAgKmmXmwVo7Lfzzy6A
	Ssr5UdTqmg7EGJgcEVVgl+WdlUuBgwxY8eSZBhPgbaAPIN9PY0p1nE+6J3nrv5zN7+c=
X-Gm-Gg: Acq92OGH8r8ieXwQs0qGHLCvnFwLXIKhuE7lWjg2YgeacB2VZeJ70xUuNuIGlFtplXP
	NeJwo59QDtKjT73qWcAVq8Rq6UsIgR/UtBCcrTO0XsHKjKqkoNx6153/7yV9Rn6nTaavviS6Yyx
	U/0MeSKrosUxOJOSqg9YGgoowSmXteJPcKH1cjSHZtC+g3p7eyaP7Q0hBOJUVPjqsUSiimqmTw3
	MhJtHQJl3ThNakJ289PCl5jSK6jp8uFfmNHDmmD3HMGN+fHuzgv2GaK0oNKFgqv27DeYUSX3ulo
	nQ+bDo7XUhUSQ/6aDr5H3VmEzerOEfqdf4fPEt26RWWJP/4SiJz4YnDlEBaADOUJtL91J/AYlCg
	jvaX8dQ7WAGaMcbD8yH34tq+hgFhlyUjjg8L2cnw/Bx5KwST/l2lzfU20voDPNOFdldP+p/CVAR
	yZ9tKEH3QphyZMYNoHRqQTVuV+oMhYX91hlPZ+iKa49lo7nLV17rzedoica6+3hEe6W8uZc+ZBh
	qg=
X-Received: by 2002:a5d:5d8a:0:b0:452:bc55:c684 with SMTP id ffacd0b85a97d-460675a50f4mr1606160f8f.19.1781153227229;
        Wed, 10 Jun 2026 21:47:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm80062581f8f.13.2026.06.10.21.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 21:47:06 -0700 (PDT)
Message-ID: <770e065d-a795-4b0b-aad0-b3b98e5ddf2e@blackwall.org>
Date: Thu, 11 Jun 2026 07:47:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/5] bridge: use atomic ops to read/change
 p->flags in br_netlink.c
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260610161836.1275531-1-edumazet@google.com>
 <20260610161836.1275531-3-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260610161836.1275531-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2026 19:18, Eric Dumazet wrote:
> Change net/bridge/br_netlink.c to use atomic operations
> to read/change bits in p->flags.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_netlink.c | 97 ++++++++++++++++++++++-------------------
>   1 file changed, 52 insertions(+), 45 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
