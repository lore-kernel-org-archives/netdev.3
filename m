Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937DD373BEC;
	Thu, 20 Aug 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249759; cv=none; b=UcAddd25cNLm8MYcaYsMgUtWvCYV9iby8z4q2NvFchesl48wVtn4Us0duETV5Ke3mzSKuEIDTjOjsFUu14ZEsb8irX3gRqwXL2PLK+Ag8r13iwM/ix/AvSMHj3FP5vhW2VsHGfYGbJQqXSRqGU2QUHhNBJ4H6Lwo55tThGWUAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249759; c=relaxed/simple;
	bh=m02GxbPae3HHpb9YhEln4ICH1u8J7yJD6qOl/MiIne8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9EJ01o0t73Hnk6zFRCscstJ6oWyfT/lVbXtbG2uxTv8Y/ttWwWTOwXy+McE4dGeZRvdb+iMT3E6F6UrR17yWyivyHpweZ8aj/OzS4d9KONNTJrMINpE+uX+FhRhQ14wO9/GMbUGh5SCu+HQj8jeFvmgyoQZVuUHAzxwJdbOUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jysh5DiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jysh5DiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFCE1F000E9;
	Thu, 20 Aug 2026 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249758;
	bh=GxT8va7ovcOW04vuuKemjJnnKgZnMkYMnuFtSFLB9Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jysh5DiYnHkR2ItPWNQFwJJD0GRas3EJR6BTgHSsfcMicXjQFoHfmErxHteLJkjkp
	 6iEDwFcUe3iRit5JTRFfEdLezCqlfnhwJ1QL8oCiJ5MkPKZQkvkUGcV55UegW/A0Q/
	 VGx6FaoTzE8c38vMKjWP0LVJ8XMmLctkVThD4nI7laEmlPRzSAPqEMuOZPPL1t0zNr
	 sMHof2eXdYpE8lrrr6Kff9YacDkbzwV1XTk988COEWY/KXU7s2rgziMq3bX6iZ3eXg
	 f/Cwgb6t5WEFK+CM7veqeGWl0U5WHxX8bmrU+rjRCXbxuQTCxdE0TCtoCrZwQI2J0p
	 s4U03C8CYHA1w==
Date: Thu, 20 Aug 2026 11:15:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Walsh <thwalsh@redhat.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
Message-ID: <20260820111557.49f658a4@kernel.org>
In-Reply-To: <CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
References: <20260818141556.64303-1-thwalsh@redhat.com>
	<CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
	<20260820103950.5dfa2969@kernel.org>
	<CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 13:55:57 -0400 Thomas Walsh wrote:
> In this particular situation, the customer had very recently upgraded their
> firmware. "RX queue restart failed: err=-95" messages were still observed.

Would you be able to share the NIC and the FW version?
Could it be that they upgraded to a version which has TPH but not queue
resets yet?  I _think_ queue resets came in 232.x but maybe there were
bugs which delayed it later.
