Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7B3D6CC5
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394775; cv=none; b=qTdkxxBoNbjT2ItHJxOCbnCQxhZqVE1Awl7EaJ1DyA455i0xzjOY1jMiHSd4jj9J9YAt2HBf7Mgo9kJxSTQ214OTYUj5A/W0oMTtRKVoYRqkZT/tVUr2m+CITUJ25UWYPv+Ao+6SJSWF4lk3lLVQo2+SIy+KMsvh+IJQB2S9hjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394775; c=relaxed/simple;
	bh=rlknWuEoyQwlhSWVRvtT4zFr2I4F0pfN2T3xeB0Ez90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezJTbqxFaSPXPj37NiINXDz/Jwrbmqy4aiR5xN6cCBRxhT31KGdcmA5QY9Udao8O8aPtXo80amwo7yFZThzLY1vZVvMNVJwB3ZEc5ZAD05mpaDybb7XNNPRsjILBHGYwLjoONYAIwV1Cp/L3vOl87BULvfp7SThxZllXXkYIyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go34lQmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go34lQmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AB41F000FF;
	Mon, 14 Sep 2026 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394769;
	bh=y2BO68yRKyao0X7Bq+wE/gvRxYMCvUFGkZ4uSJiTbJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=go34lQmpupFl9oSgClF3NFB7zTKs2mFnoq9dmYvTdMyqZ046uP4aFB0WEN+KtLKy8
	 wuWU2Bd0V3K3TsBArZf/1NyWJ8HQQ6RegsEUkJQuQUF0U0OEVHGM6kmXxJya3FRxxa
	 xF5RIvWgKB+vMXwjOFH4eE25+mDH9qdNPWTU3ZdAaEJUUk//5c7LWuunGYulwROOuZ
	 QN3wetgY6PB0uIag/ZSmS6ggCFL3sVlEwjwvG5tNINdj8ET1rPxq3OKXajXWWYczf3
	 gjGTYIIjxPF8Wj2ktKfquw0jVppPhGeL3GQOeN5wv8GWdo0s7mpeMB+iKYjMZ2+5G9
	 L+fdqNe9Lbvdg==
Message-ID: <c50249fa-ceaf-4c53-a69f-603adb482326@kernel.org>
Date: Mon, 14 Sep 2026 08:06:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iprule: warn about host bits in IPv4 rule
 prefixes
Content-Language: en-US
To: Zhixing Chen <running910@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20260904033138.10620-1-running910@gmail.com>
 <cd7e9145-20f4-43f7-9c18-c323b9d13a9e@kernel.org>
 <CAMyuFdWdeDna+FMmOkJwQOCN4GO6=Zu4m5DyX7XbeT=Zqr6PKQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAMyuFdWdeDna+FMmOkJwQOCN4GO6=Zu4m5DyX7XbeT=Zqr6PKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 2:45 AM, Zhixing Chen wrote:
> Hi David,
> 
>> detects more than just host entries in the mask, no? 10.1.0.0/8 would
>> also throw a warning mesage, but that is not a host address
> 
> Thanks, that is a fair point.
> 
> What I meant to check is non-zero bits outside the prefix length, not
> "host addresses" specifically. I agree the wording is misleading.
> 
> Do you think a warning explaining the actual match would be useful, e.g.
> 
>   Warning: from 10.1.0.0/8 matches 10.0.0.0/8; bits outside the prefix
> are ignored
> 
> or would you prefer not to warn about this in iproute2?
> 
> I am not strongly attached to the patch. I noticed this after I was
> initially surprised by rules such as 192.168.0.147/24 matching the whole
> 192.168.0.0/24 prefix.
> 

I do not believe it is a big deal and that code has existed for a very
long time.

