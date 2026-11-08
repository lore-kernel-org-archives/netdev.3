Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144551;
	b=ll/UMxm+0r1XQOpgIeUEM8d/pSpwvt17FUpqs9hf2yvFOVUY52yUDpeubO0cwfWWe9Xy
	 +4fV/NPJbDT23A79VGJDUJtXUmehYOpI1keP7hlHCVsu7Bxwaw4o5uT7n9LuKkSPAIuYH
	 fw8ad9MyhuX2bXAvLYw2XucY3AQ44VXINAOFllUZUDL6Y3r+UhEb8JHqng6MjiiYqIIKS
	 iGx2gjKk/fAy5ThrDkftQcvRO7ddrGmRJOxespJMzfnxkSPQQqqJFSByb3LVXHRANS/jg
	 UjI1auBhcOa+87CacXoh5DCQkD3RKScXmqaFU4D6o9oPx+WLxNnewwkSo8xVx9ofhyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lRccb7zFXAZRlpy06P3LA8/Kjn5v7zQ+e9MSG+eMWK8=;
	b=x9ZaNeX9YPeuGu74w0iEcSfcH6vR+L/FL+uhOfbj+Y4nLPR3wx+knQQzlklTmErwxBma
	 6cfwTS2QSzeg5Yt/C5fRf5z38R2RJaNaC/BX2Q7oXNPQWWWrA8aIqPSZzM/jtH9yhNFLJ
	 wnQXI90XD4Up6A7qLpKqTtsO4pnzeYmfWXhThpKOnWMjXJsLvehKj0zuj/NEqe3hgGct1
	 B+JcIJHcrwgSjgsKPwFjjLaF/l16oZFodTnkYql+53Gj97qGdHZ9YPBAi6tRQ+aodUaUz
	 rm+cBWzevcRSe2UCLgGZdXBiXeSfEgLOsEDnseVi6JR4nNjY6hdyFWqEWuo0d657M/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC9606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99CC9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ebf4cd218so1042346d6.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1794144543; x=1794749343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRccb7zFXAZRlpy06P3LA8/Kjn5v7zQ+e9MSG+eMWK8=;
        b=BsxPqebZhw4rwrPqtv53XeehDB+Qy+5VYjNtjlVtbXzKrNFs48pKsl084nQv1iDXcG
         Viz95t6gEbKnMnY3HnxYdZRsCNtzZyWwFHmrJ9DHWP6tjv0sfeZa/DOL3vJD3tnjY86y
         jN4EdwZIQIDX66WX+Mcmorc9xgAqG4pbEfd8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794144543; x=1794749343;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRccb7zFXAZRlpy06P3LA8/Kjn5v7zQ+e9MSG+eMWK8=;
        b=vR352A7c4oqnmlskyp9+zDpDKNwCCOBsrjiyIpfuNtgzTvxIOJjhoqNuE1yu6isF7O
         2FsnfOWReRtkAD6PQNzNwEPe/ORfbDO75k+EoD9DIxUjjCWXpBCQIwQBK6NNuRQORxfO
         xCRyIiYQL0qXIvIHB668ypomHoJVd7C/ORTKgj2bx8uZzbyXhvl6cQ+gRxm4AvezRzwr
         H1lmGn9/vhD8tLI+aMBwjrWEU0MBjxApHumpxGVPWmE1jSDAS5gMnmJJL0AO/BgfoQ+I
         QbSNeE1bPZvKhCvLfC2afr6e4cW0Pox3Vhm1O1zR9URbGpixC/UxIj9dJLnq6XrVjkxT
         8G+g==
X-Forwarded-Encrypted: i=1; AL+hErHpFHqpMfop68ytzRA14p7mJl5IWSdGiMr2tc+oYfQbrZBbbuxi5tF7vaBvwqAMQbcQ7KUO3lY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YYI47dNSTS+rRx7Bl6C03be9gddZSoZ5010oEyWynm10Dqx6/
	CbtlngL7Z2SvZJ9RuKKGoe99I5W1EeskIqX68asOoshBgq8zVp2KNdSEV3whi2+Bjw==
X-Gm-Gg: AYBFou0j39xfi4ZVa53naDy++3YgGgrQoYXmiG2lU25QbdbltDg5FdgEhHwT6MVsOnD
	o3ZY+HCu1Kqfpz9DgxQaxypJNlGUETy4PjOyxEtst/lMewrRdHaBA3bhXoyRBzInYWL0n92D/SM
	usSAWstxYZnpL3acsYhkJ5fj+hSx+BDUN12sVkVPYY57rNLzvpZ6EDYLEAhLSsYgE0+KtcvR7qF
	NVdnQVORn5hlYf4JfuMrJrlM0UiKmklnRx7UApJT/tED9Q4IoJ+M6tRaFJiCZDYfeMvsQdxlbno
	X8Ux9w4qlqLfKk+vm+WWLDpIZa+YbkrEj/sWpxfV6yXP9UM7L4Ka6YSi/hex5YBMRPEPrerjDGX
	YT3KmOQTMf9F4KfTZSM0grctg/+95FeLzl0DWC4Ew2CTCTfDxcYDNP8jLCKGTjpOmqJNA2G8cUI
	tYMueJhJnZ2/isMXZ0l4NuZKtVQvN8i1wfCxvqXcXWFR5/ahXwCr8wgU0CVuwoaSf9Nu5VD83dO
	6UC9r0DrChqKXgv0UZcXZ9eUpU32sZl/j4d4u6S6cfBVLRYS82Xfm7Ptfj0XpHrxPWZ5sj1zhiA
	2FhvtgAdF7aV7GLk9L6aWadK2od4A6A=
X-Received: by 2002:a05:620a:880d:b0:939:6dea:374d with SMTP id af79cd13be357-9478474cda4mr191133785a.49.1794144543434;
        Sun, 08 Nov 2026 05:29:03 -0800 (PST)
Received: from [10.211.55.5] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-94782ccb826sm208255485a.6.2026.11.08.05.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 05:29:02 -0800 (PST)
Message-ID: <84720345-3fc8-4320-8bd3-ca23b3c9c69c@ieee.org>
Date: Sun, 8 Nov 2026 07:29:01 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Fix runtime PM reference leak in ipa_remove()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 elder@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20260917115115.2149796-1-vulab@iscas.ac.cn>
 <7509f005-709d-46d5-8554-b9d2fd0cd218@ieee.org>
 <20261108102500.3182111-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20261108102500.3182111-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 4:25 AM, Wentao Liang wrote:
> Hi Alex,
> 
> Sorry for the very late reply, and for the noise.

Sounds like you learned a few things:
- Always base your work on a recent published branch (like
   the latest Linux -rc, or linux-next/master, or whatever
   the maintainer prefers).
- When using tools like your static analysis tool and/or AI
   assistance as a major part of your effort, state that with
   and "Assisted-by" tag.
- Pace yourself on sending patches, allowing reviewers time
   to see them.  At least one day (so people anywhere in the
   world will get a chance), and more (because people are also
   busy).

Consider the last point especially true on AI-generated content.
Take the extra time to really review in depth any change, and
really understand its effects (both locally, and in the broader
context of where the code sits in the system).

One last lesson is that a single apology message to anyone who
might have been affected by your messages would have been fine.
I got three, and they largely overlapped each other.

It's OK, but I'm glad you view this as something you have learned
from.  Keep going, but keep improving.

					-Alex
> 
> You are right that this is already fixed, and I should have caught it
> before posting.  6b9eaa61ff2df ("net: ipa: balance runtime PM reference on
> remove error") makes the same change, and it has been in mainline since
> v7.3-rc1.  I rechecked ipa_remove() in the current tree, and that error
> path now releases the reference:
> 
> 			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
> 				ERR_PTR(ret));
> 			pm_runtime_put_noidle(dev);
> 			return;
> 
> so the usage count is balanced there and there is nothing left to fix.
> The patch needs no v2; please disregard it.  The patchwork entry already
> shows as not applicable.
> 
> You asked how I found the problem.  The candidate came from our static
> analysis tooling, which flagged the missing put on that error path.  I
> then used DeepSeek and GPT-6.1 Sol to audit the finding and to help write
> the change, and I reviewed the result myself before sending it.
> 
> What I got wrong is that the diff was prepared from an old snapshot
> (v7.1-rc4 based) and I did not check the current tree before posting, so
> I missed that the fix had already landed.  That is on me, and I am sorry
> for the review time it cost you.
> 
> I am going through the outstanding feedback on my patches by hand now,
> thread by thread, and will answer each one.
> 
> Thanks,
> Wentao

