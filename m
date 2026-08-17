Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8244C664;
	Mon, 17 Aug 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984152; cv=none; b=oBjTAGG/lQMqOFF9zDFCAFKt74AkHospFkQFfo4hY4scwsg2wnEmOpUcCv5SLa6OCHsDK51piN7MQlx9VLhM+WQGgrVJ6BplhGqGw7OBx4QBgXXY8emxgVQiVEWN/Axb/B0pVSV96XkAHr3+lmaFpPdP6FJ9gPR/s8mEAwuJVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984152; c=relaxed/simple;
	bh=iiuVpwoJTqHCLXiXbmEr5DmPrgM2eROWaY9sEmB803Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltuIrXzzbfpVlHHIv8fyGiwduW6SKa8nVDDnCK2KlzwzsPbri43hTiwESggsbblhw6DYbOpNgXdtoisptcxDsJU80NZgzNlMQei45Vm7ij27vWfCkQTOIhkxy9yELmCNp26A9iKxXXwNQzG/jsgGKshUCqEasfACKsfAgqfTD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbMElsw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbMElsw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9327F1F000E9;
	Mon, 17 Aug 2026 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786984151;
	bh=iiuVpwoJTqHCLXiXbmEr5DmPrgM2eROWaY9sEmB803Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NbMElsw+9wKWZCy5MrMlJIDheVLPBtPMbTfq2SwVrp/EFyr8CaNM9M3/3W/+ecOzO
	 JdLAV/BsSvZAHobIo1zXP0oDzhBiOsUjNAEYT0Zgz1q5iu0ISlYPz7uRkltf6fb50r
	 thfc9GWGc05DrH6DskkF7gkGfLeiZ3eEIAPMYz+AH23ZJkM3Uc3OkZZ+0uSpDYW9dJ
	 8QFQ09bo1Pwtrkkf8lO8n6HHKY5N1lE4PvCooHG4+QaMUkLGLgxhfTr9A0OHURK/7A
	 5IdBDHxPaBaqjgcLA4TTxae5p2mNZBgAeJxPGnbFU6vTplePK0FkOeExN0sa6K7Zq1
	 2flG10GCu3vRw==
Date: Mon, 17 Aug 2026 09:29:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lee <david.lee@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, Kyle Zeng
 <kylebot@openai.com>, "Dominik 'Disconnect3d' Czarnota"
 <dominik.czarnota@trailofbits.com>, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: defer qdisc freeing after failed
 creation
Message-ID: <20260817092910.6f941bd9@kernel.org>
In-Reply-To: <CAC_etQFk=tGLvbHPmQwOyrYWgRtDru3dSw4T7sZ-9hvVMy_J-g@mail.gmail.com>
References: <20260805102505.740806-1-david.lee@trailofbits.com>
	<CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
	<CAC_etQEByQLf5pMWzbyVfT3xtzereqEgu+XZYmwDjyvpRCzxjg@mail.gmail.com>
	<20260812182246.3df00681@kernel.org>
	<CAC_etQFk=tGLvbHPmQwOyrYWgRtDru3dSw4T7sZ-9hvVMy_J-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 05:06:01 -0400 David Lee wrote:
> Apologies for the confusion. I've reattached the correct reproducer.


please see my feedback on the change itself (if you haven't)
