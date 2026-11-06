Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998747;
	b=p1P3wR8+saFcu2aPKZ/u2vvB4LugCoWTahTYEeLEBk9iIMy+qQlEUtuvXYr3KLph2Lu2
	 xFxK2UKE7Of8X0yl4H2mAfTre7GagZIkr8CIeQN9uRGwV+jM/N+/vkVVjyiEC5mcwiKP9
	 dKdLyPDWNSFU+NyCET5nNFXbDrEpAXo4bv/hhJ6LR1GsQZVoj5VkKYY9Khy2/6SIhzeiP
	 VsK90IanL7iZFSjfyitEixmr9uYDojkAqArHIiWZwCEJkySD94G8gvhc49/OkFM5uqDrz
	 4OyHaGMeLf+3l2qkIQO374S6g1Z+HEpzOquEFChuaN9m9DPD/5NQMGYGp5StdzHevkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998747;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BWePBkvlMSn1hPXLcVH+/mo63ATasbBJZxDB/+AnkDA=;
	b=NE4PwrQHqipsju27Fv85gdbsIxPs5ZAU/OOlbt3bAervh2CrtnPxrte1No5nrI6f7asy
	 bFBvcleGt7/F+LRv4A18MZJ8B7pnxZgrCo3KIh3+mdF6TK1S9xWSzWJYc5jECQ2du/SWT
	 JUszmXZ2J5hqmZHN2SvieN4GiMGrUnKH626fOsQVOyuXtQFddBeMzlp85K9nL5SODV8VT
	 900zu2u6LsRRmHp/KM9cbzHyZo+Yx8g/8EdfrIqVw2HUwT7i5J7M2a/QKQHDWZRMgaqfY
	 eYJdmmPFexc4VOQo6gyApvYd1xV/hg/ay0HRXPS+WGo8IEmYqvJSCIXoXgiYt94gc5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4lXcGKF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA7606A330;
	Fri,  6 Nov 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4lXcGKF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EBA1F008A1;
	Fri,  6 Nov 2026 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998747;
	bh=BWePBkvlMSn1hPXLcVH+/mo63ATasbBJZxDB/+AnkDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f4lXcGKFqeBcIf9fVxl3R55CHj7mybi8uDMb3J5Hbde9Y5Rvp8sbG9yGr5+WGEROj
	 HKpoeOOcvICkGlTz/NXnGIZd8brO/CFbr4P25mjmRawznOrGEBjoJ+1asT6duYhqhb
	 4XgDDuYFOFFw6DzYkJWIikLuM7GavCrZsmaIX3m2Bu887ED8VCq/HDyl8MKmNd5+5P
	 0Ur3xvYEuvwpOtDkCF3hK/0RExFfwucf2Alw4FcVhxiS+jHyV3Kh2XP8IuoWwLfzr6
	 +X4i/Ir0/54/NfLBZo+m54KHKwqXCIqNF5ucTFrPRJsYyHTuac+qOG9vbIIn/BR7ks
	 X+yshxy99q73A==
Date: Fri, 6 Nov 2026 12:59:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net-next v2 0/2] devlink: do not dereference a missing
 param item or shared buffer
Message-ID: <20261106125904.2961bc3b@kernel.org>
In-Reply-To: <20261102131505.611343-1-xiaolinkui@126.com>
References: <20261102131505.611343-1-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 21:15:03 +0800 Linkui Xiao wrote:
> Two devlink helpers look an object up by id or index, warn when the
> lookup fails, and then pass the NULL result to code that dereferences
> it. A driver mistake (a param_id that was never registered, an sb_index
> that was never registered or is unregistered twice) therefore costs an
> oops instead of a warning.

This is a very low value contribution.

Please think harder whether the changes you're making are worth
community's time.
