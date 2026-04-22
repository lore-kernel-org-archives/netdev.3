Received: from winds.org (winds.org [68.75.195.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1232470F;
	Wed, 22 Apr 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.75.195.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871183; cv=none; b=uSRPiZBrcxJe8+D9AScpj9IMapXdKra/H9nSwQy3rPLDSLg0hA7MJqZCq8ZvGfwNEINj1AaGDQONhuPwAPAgfLZpsVbI5/t81QNdr2c6kfPqeu0zuseOh8dOozqMzZX8dG4N+VVngNsGMOkDUByOv4wrDdpOdkguWSL29xWeA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871183; c=relaxed/simple;
	bh=n5AnSYUIJdNciSqw0JFqdXr9t6s/FxzrTVOnpRgJ7Qo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZTAd8Y4TEJ+AXNy0EfCN68MIBJKpin/aCl02wCKvCqexyNSdFw736BChGCHs2C9AEfClfZor//U/6wH6Gv8IxFKxvnuD5uAhuHx6deXtmQCtMbsfoQCCY1pqWNjXih+r64knSL4q9H7mjrineBSD0WZDV0k3PnuFXQ7nu/P3H6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org; spf=pass smtp.mailfrom=winds.org; arc=none smtp.client-ip=68.75.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winds.org
Received: by winds.org (Postfix, from userid 100)
	id E2E5F8F95F80; Wed, 22 Apr 2026 11:19:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by winds.org (Postfix) with ESMTP id E1C7013369000;
	Wed, 22 Apr 2026 11:19:40 -0400 (EDT)
Date: Wed, 22 Apr 2026 11:19:40 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
In-Reply-To: <41d9fe43-9aa5-49b4-89cd-9aa13e4e4ea9@lunn.ch>
Message-ID: <ba9302dd-105c-09e4-90ed-fe56addb6ca1@winds.org>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch> <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org> <e056d348-4560-4df3-85c4-e29393b004e9@lunn.ch> <9a0bc592-fb74-f646-1752-4359c0ac31a2@polinggroup.com>
 <41d9fe43-9aa5-49b4-89cd-9aa13e4e4ea9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

On Wed, 22 Apr 2026, Andrew Lunn wrote:

> On Tue, Apr 21, 2026 at 11:03:28PM -0400, Byron Stanoszek wrote:
>> On Wed, 22 Apr 2026, Andrew Lunn wrote:
>>>
>>> Could you live with v6.18, which has an expected EOL of December 2028?
>>> If you are only updating once per year, security is not an issue, you
>>> just want stability.
>>
>> I could for the time being, but this hasn't worked for me in the past.
>> Usually what happens is the PC breaks down, and the customer swaps in a new
>> backplane+SBC and moves all their PCI cards over. I then find I need to
>> update the kernel just to get the Intel DRM to work properly on the new CPU.
>> Some of these systems were installed back in the Linux 2.6 era, so I've gone
>> through several "Intel DRM not working" steps ever since CPUs started
>> getting integrated graphics. 2028 will come fast.
>
> Hi Byron
>
> I will drop this driver from the patchset.

Andrew,

Thank you very much.

  -Byron

