Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A32F60CC;
	Sat,  4 Apr 2026 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775285265; cv=none; b=kZLJG2fvB5K6udVC3YPzV+XN0MzJXGaQ2TyfJMBYz2RNgl7h1eNQCJz3IascEmfEvtnhJRlKwV8MvmUX/Aw9m2dDxqlEl9JtaMa8KN3WkZNMEPo0FquJ59IEw+K6CxwesuWwqBesDoqv+gCJTojUk731QNUB7k9+GgqG1BhhfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775285265; c=relaxed/simple;
	bh=XAwJvcrO6lNB3FEqBBsjGjIoCjnUTt4u/LgkHw0Ia0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWduGA8AnjAvgyWJBeJcoch2zynMSyizdvWVFtn0FBOwhr0E2nkYZ15fuJ5PFO3YwzpH74k4LGrSpHGSgORsgWNIaG17A/lvi8kDP3dVXKmOmnGgM6Ho6WjdVIUrIWvbbgISBvKQy6ZIng+HrOOPc/wLR2pvuO/+Zi6vsuk3AgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zkz/qr1g; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vnsVlbgV; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zkz/qr1g";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vnsVlbgV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775285262;
	bh=XAwJvcrO6lNB3FEqBBsjGjIoCjnUTt4u/LgkHw0Ia0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zkz/qr1gkgkKLjpYUPH/ET6zhvWqP8lJY95rqeF2bEMpQl6l6z5XCmpcJK+JoADmd
	 AX7oXFhdfc8sge3ji0U75pFowayK06aRmGSZ8TkXotyzSlPo3lq953ti6NktvNl3QW
	 d+3KUKekmdmdiIf2HEAD8wR8TLSaaMxscNi7pPxfK/swRwMlblD5FskyIREDB9tW51
	 sOhRDxNtyCtwICe9qYRaS8VEBPykvwXRTUlZ+EkyrhGcuDyLvIlr4MvoSYOLk7tNYn
	 pdmPAhS1uUgZVnJCfZWZsKCtPm18shQBmhFYoMiFH01COLABCvhDQQzh3qGkHxcE3z
	 rI3O3zBc38+1w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8AEDD4091A; Sat,  4 Apr 2026 06:47:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775285261;
	bh=XAwJvcrO6lNB3FEqBBsjGjIoCjnUTt4u/LgkHw0Ia0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vnsVlbgV9hlDrRHZi1Gmdm8FnvykA9O8f8r7kIXxUHsOXa6el1f3/xfptvNtNdu09
	 xHJggOUK1yCLa/oEktgckbmugoFIrkd9MnBlHQK7sS8JY2DXlmeanwT9lhe0Xci/rL
	 kJloUYooBSfXxVNe9FLIgloyD287d+BLAT2r6PYbAwncFCVYsSmtaqgFJ8PiXTCfN5
	 awC0CcA7krfVxjI4UqANu/r6pSXevtfpqdLbJTul/c9MykoBf+nD9H6fSdrYDel8K8
	 TZ/54g9a32an5Kn7lKHXO4HTPzHZ0J10Ia7yxi0zoy0UIZk0SpTHjFC1XIeOjd/8OM
	 YHUECs4JfW04A==
Received: from [IPV6:2003:c6:9f04:eb00:ab14:e4b1:3dbb:7eb8] (p200300c69f04eb00ab14e4b13dbb7eb8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00:ab14:e4b1:3dbb:7eb8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 99B2840904;
	Sat,  4 Apr 2026 06:47:41 +0000 (UTC)
Message-ID: <23860a3b-5c89-42d8-bf7f-2f77f35cf14a@birger-koblitz.de>
Date: Sat, 4 Apr 2026 08:47:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
 <20260403160608.04f2408b@kernel.org>
 <741bde66-45b7-49e4-88be-7fb1ca8a92df@birger-koblitz.de>
 <2026040421-kite-ethanol-2e28@gregkh>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <2026040421-kite-ethanol-2e28@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2026 08:27, Greg KH wrote:
> On Sat, Apr 04, 2026 at 05:54:43AM +0200, Birger Koblitz wrote:
>> On 04/04/2026 01:06, Jakub Kicinski wrote:
>>> On Thu, 02 Apr 2026 10:28:12 +0200 Birger Koblitz wrote:
>>>> Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
>>>> chip in the RTL815x family of chips.
>>>
>>> no longer applies, please rebase & repost
>> It looks like you are letting me play out the story of the hare and the
>> hedgehog. If there is no interest in this patch series or you would like
>> it to look different, please let me know instead of playing games.
> 
> "Does not apply" is not a game, you just need to rebase and resubmit as
> others are also doing work on the same driver at the same time, so there
> can be some conflicts that it is up to the submitter to resolve.
> 
> This is normal kernel development, has always been this way.
> 

Thanks for the feedback, Greg!
the underlying issue is that parts of the patch I submitted are now also
submitted by others, and that gets fast-tracked. This has now happened twice,
and I am being told every time to re-submit, without efforts to coordinate
this, or hints that this pattern may stop. This has somewhat made me loose
trust in the process.

I'll nevertheless rebase and resend, and see what happens next.

Birger
