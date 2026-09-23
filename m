Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F2479863;
	Wed, 23 Sep 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154755; cv=none; b=qCtkut0PY+Co8WeXsTUBzO689ykbjdeOyux7tbLDpjCTqhNFSOLMGC/VrimAYVyaO09Se2IQ4euSVXjszZmTOzmrNuScpL0pCGiCYMLOiIoCoDj91bdmmlx+a1vuuIylZcTuisa+I4j/YJr7oALgbKo/lvyC2bf5beF5NiLlKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154755; c=relaxed/simple;
	bh=SAGVK9OPDvqZ1jJKLqmuMYQ2rVjzfprfyjrxl+sHNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/1vzKVHST3XeMYZ5b1PNFqYxjgCeVpWr5gb4Iyy+wXDbpVsY2l7imW5owez8f1LMzJq7SqJZ8pdEJ+uzi0Fz2xPFK6hf3z8v/dHfZePmY3kn8ibEu2Y7qSinxTaU18Dh8uMiSOoG7mJYKH+uyOhvnndZA5Ga3XfzXX0AZT2TJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=oHfb5M+F; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="oHfb5M+F"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC7F53EBC9;
	Wed, 23 Sep 2026 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790154745; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=XaWFynU97Xs0bJVkikFT8nA/Q51SOMSnMNYGzRCbHhg=;
	b=oHfb5M+FSYpxbL2hzH6kdAlfs2u0jFGnmNU6ywtPYtrJG+D07go/nlkttBqpAaZSBtZdE3
	PgbhZd1+qdTFBfUtYrvwBDE1QE/uVEVwrUaytqvKKziCLrP2qO/5DlhDF5WZe3GS+hoqj2
	gDUE5tVN+G40zotFoOIA/aUtlFtdVnyan7gu1Cy/ajvUrQ8/zJfno9MVz+UBrK/09grFfH
	lN0+I8TFebd7nigqzaw8zjs15vxYfTkOXo2RYVRAnYmcI8tgy2bQcd4h+5R+aVC8m/wFK6
	p6Ya1plZJO5fKPcBXz5Zq6HFSt47qdwkPuls7nfC9g/awUjxvfXRmS5mEI9sGA==
Date: Wed, 23 Sep 2026 11:12:21 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <20260923091221.GA90128@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260918-wiznet-link-gpio-v9-1-5536f24d8d6d@marmottus.net>
 <179009180465.2160803.12754142201441824675@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179009180465.2160803.12754142201441824675@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEbO+S7deTUsJDFY882Iwbc5iPiEjvYLSxRbrdyUBxZ8cKU/OJLRSfMrv9Odm7Wm1uqjo2WHtggfCf+d3x02XnqFbNm7e/idwNvSTj0VoV/5obZ7szriDueefipeyQC4PO8Bu5q+tdPu+Vzwm9grBQlmXo2/eAL7lzvTI97U7bjRkJCYyiproJcYyM8AZiLNbq788XY+mCvyUlr2oRfOCSIpeOZ8tY4ZEXRxcvgz0HSoPTfLrucbG/UcRTvnntgu23/+0703Y1w9Fp9wM3fGlFbc3mCAhufQ7a2dWOhxIbtHzKKDaYyq9xzOxt9NTPh8UGc2tyqh6LJAeCRPtKT5JrzjxJEmz7lgVDJxoX0hvISTJl/fE5zgXk8RBwIsah65FHr1koUKlZY+Mnsify4WTq3+wK4DIpkOawB2se441UnHEBlf0PBvtCFYQ0iuBJ+LqFZbc2zFkq1GMDXztH/VIrZrqRBIr2xQN5YnwlX+3VQC74RnO1p440yNx/QIniyrzNJqmes6LVf2h91z/IJq79vC+Qti6kKQz5EiknU99wxsSqCqlYuFysFt66lRy6kLidIzRKsyBLKAESFLlitpm9D2B5XCAn1EDG0ABXGRVh6wBuXiJRKCMv6s773GEpfyQamtLTZ/uAq9WbYDs3LjttTX9XvviCvJry8X+Qk6ss6uA
X-GND-State: clean

On Tue, Sep 22, 2026 at 03:43:24PM +0000, netdev-bot+sashiko@kernel.org wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cae5962045dd..e6a5a4e245a0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -29439,6 +29439,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
>>  S:	Maintained
>>  F:	drivers/input/misc/wistron_btns.c
>>
>> +WIZNET W5100 ETHERNET DRIVER
>> +M:	Arthur Crepin Leblond <arthur@marmottus.net>
>> +L:	netdev@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>
>[Severity: Low]
>Could the commit message mention this new MAINTAINERS section?  The
>preserved log text only describes the .txt to YAML conversion and the
>edge-falling to level-low trigger change; the new maintainership claim is
>mentioned only in the changelog below the --- separator, which does not end
>up in git history.
>
>The section is named as a driver entry, but its only F: line matches the
>binding file, so at this commit scripts/get_maintainer.pl will not route
>drivers/net/ethernet/wiznet/ changes here.  That part is addressed later in
>the same series: the commit "w5100: detect carrier state using link status
>bit and optional interrupt" adds F: drivers/net/ethernet/wiznet/ to this
>section, so the mismatch exists only between this patch and that one.
>

I'll update the commit and the MAINTAINERS file.

Arthur
