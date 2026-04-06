Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C95332EBB
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491353; cv=none; b=ezZ1CmyOvEzRqONmUpYKwMsTBCBG42qXOFDjNOk2CyuaMGO2Rxzq+HPc6UEiP9f690cJgdDrhJdJvp1dqR5N5z7yJuAdWAy7xWx25LEVMqtW36PDcPMicWA86NCf23CnSUxfNx1eTE3B71ThwpGfsjR90gfm04jq1HoA++6S2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491353; c=relaxed/simple;
	bh=YSh4/eWZtBUyplqjZoLe6Uo7AkBSSdqrQYDVNXw4qmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS/aQxAMn5B43y+tm1jgktsZNGZWND7PSh/e3q6xsjkf5qLqvao7D0MlBTZ6Vm7bhe1ECSf35gDD9gBKjjbWL6rA56SOyrbGglzsB7RkKBpi5Qi5qcHrfGXCR4kjJx8nn8BuKjkelCam4Be6tQ646fWazwc9kj271NSIrNbaOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGLEr/Ki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGLEr/Ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7315EC4CEF7;
	Mon,  6 Apr 2026 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775491352;
	bh=YSh4/eWZtBUyplqjZoLe6Uo7AkBSSdqrQYDVNXw4qmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lGLEr/KisHGlHOvbUqrvOkYkxxr7NI9+fzpJk+KfHRupERZXxp7lH7kZEMbI/Aysi
	 JMD15XoTYMpMTOE/qeDPBY0oB2n9QpnGYjFixDfexOekAMe2YgBLqcfjbOeGYms/44
	 0Oq05Jcn8dPHI/7Ct0xAvYcNZxM+h8TwFmnprYHWlmUCSukNYUtnBThoeKzY5lx6WS
	 LJ30qXwgL00fkE5ekaSLXZRio9V0mB7OiZeznfNSA2YEJAvyXfqz8ho9BNZxvzuhLG
	 uza7IJxX1XFq23CCRuhLq8PC/RVXLm7HyioEr/a7OeHtjvozhbSgaX9vSsiBR2V6M4
	 xQkaicObUprhw==
Date: Mon, 6 Apr 2026 09:02:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2] selftests/net: convert so_txtime to drv-net
Message-ID: <20260406090231.63df3fac@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1622322e50a5d@gmail.com>
References: <20260405014458.1038165-1-willemdebruijn.kernel@gmail.com>
	<willemdebruijn.kernel.1622322e50a5d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 04 Apr 2026 22:20:15 -0400 Willem de Bruijn wrote:
> > +YNL_GEN_FILES := \
> > +	psp_responder \
> > +	so_txtime  
> 
> This should just go under TEST_GEN_FILES (sashiko)
> 
> I don't quite understand the check_selftest check_new_files_makefile
> failure.

Glancing at the code you were missing the 

# end of YNL_GEN_FILES

trailer.

Those checkers are equally annoying and easy to run locally, they
take a path to the modified file and say "good" / "bad".
