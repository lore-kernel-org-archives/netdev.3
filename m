Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E3233952;
	Wed, 22 Jul 2026 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681243; cv=none; b=J4YJW4OEeP2N3y2EUrZxVuhzVqt5wDe2Hs3EKiFJEZMkJgCzh8/f5IstRmKBeEAyW5aFdPnnjHZ3uqAuTRXTGwAaWxj49jETFeiUIfNIH0luFDXKXx69nXamk///AI9YgvTh0Q+Xb83QDGzG/LLnuQPqhtLCPTNLDdblR5WNjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681243; c=relaxed/simple;
	bh=Dbxt99CcSk91N6kAMzUVBoVJTnuSRY7vD+PSCBQdHeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnWFjcPeE/HjFFGLIHqDM4RTfsJXaM5d6niBzpnVM0WbENhTxa050gYbAHJ/9yPFtR1Fk2Emukv3LrOHffiUN0kyawyXXZew0Vw8kxLRscvNNTMrGsfe4DDp8tUR5e03gnaF1zyO5IS24oAjU8no3qYngwF1jEZUJUBXTSow70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fml/eVm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fml/eVm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F32B1F000E9;
	Wed, 22 Jul 2026 00:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681242;
	bh=PEQWfYOLeykuy6ki2YoiRUIpNjq1QI9iucu8Yn0Xugw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fml/eVm1yChZeI9rwx5PjIZq99m1GTTM73+DsBc2iaC60Ey8VsxCwd/ZQmoTnpjmN
	 JOdL9DZqHAT3+jNHlT/YCmMwunzDIE3Tjz4dom7uOwvFY670oILDzAbndAJ95dU4X6
	 5BBwiLdWAVzfZd3mpMqqwgFSUVfd4quGmbsH7CEztjMAQ8OBVI3RGXdC7vD2ZvcxiR
	 wXy3tQaP1GXs9vj5xkBIU/U3IPyyAS1vBBgFKQww19rQdbevjhdut+c5uYufRg31vX
	 6m8VOrrp8MiMCkdMp+2kdSr8tyCJ+h/TpTj7LccnXTdHRf+rIwOFPQHZarZLxLyGoJ
	 jdTa8kutixoxQ==
Date: Tue, 21 Jul 2026 17:47:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, Milena
 Olech <milena.olech@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>
Subject: Re: [PATCH v3 net] idpf: disable PTM on probe failure and on remove
Message-ID: <20260721174721.3db8fe7d@kernel.org>
In-Reply-To: <20260721174642.7749143e@kernel.org>
References: <20260720143511.43408-1-mhun512@gmail.com>
	<20260721174642.7749143e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 17:46:42 -0700 Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 23:35:10 +0900 Myeonghun Pak wrote:
> > Subject: [PATCH v3 net] idpf: disable PTM on probe failure and on remove  
> 
> Please try not to change the subject of your patches when you respin.
> It breaks version tracking. Ideally you'd tag this as iwl not net.
> We don't apply intel NIC patches directly.

Of course this is for future reference. Do not repost this unless
someone gives you real feedback.
