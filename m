Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2A2D12F3
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304691; cv=none; b=Ek5EtV1w1crrCSUpjw8zVgWAn+MuP2I0PMr+OoA9v6i9NM7LDcGwH4119qsWE4q+AivSykN7HPxSXpy0bi+RtB3ci0GvkqnI1WB2T7SQnIysprdLCt+f+Of+QqkVJOr5hQvxucwLbusX1pjrttxgW7qpTF9nWoMI6XP58pwoHQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304691; c=relaxed/simple;
	bh=U6koZ9AqIWil86Nvd1k2QWwJYqf5sb/va8y04/LnJM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LAgB/5iDEvVrhJHzlGLqG5aTDP9kCSZ2S31nQms0nDOTUQhwzEuMImxPU2PSIjSR8AD4/189JzwcE8wED40aeYw0Eevzj1kDxVFdDvf9umSxeON2dFiX5miIqCeMxYBR5/kHr4kmsG4NY7ywgQiXFZqni/PwpKz59srAWE+WENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ort9WEpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ort9WEpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8891F000E9;
	Tue,  1 Sep 2026 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788304690;
	bh=1PKxczNzT9SihUt4yRoWDWWzKK2V+GNwtVRJxz1y2CE=;
	h=Date:From:To:Cc:Subject;
	b=ort9WEpq0gwTwkvVD2O//6KD8PUA/vYl6RoMMqArbgMRKT2sE4tCJnY2BM45VJJR3
	 2HiQwWxvta1p8dgyCFnO9bgaYRsyOOyvZlkY8k/O7uXfGcNbsWnSs4fPsuro8gCpvU
	 /vCCwj/tBjRK1p+dWhImJEDRAtP7Uzu3VDagb3HE5dTog1AHFAd4uBtDG2g8cLQgE8
	 0jpXwt84bIDmSJa9SuWZIKaleIeybCySmLY9CATDSJCDbvm+0udT2+SyzWaqIh+OiL
	 CTf81bppyaX/MVSGav9968KgnbVqztiDvuDPai/mCX4SVdtqebyhECsmnOLWFl3BNt
	 cS+EisFFbW+Kg==
Date: Tue, 1 Sep 2026 16:18:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [ANN] AI reviews are getting emailed out now
Message-ID: <20260901161809.0608949b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

As mentioned previously we were trying to get false positive rate low
enough to start sending AI reviews out automatically.

According to the stats for the last 3 weeks 70-80% of the patches we
are applying have no issue with severity higher than Low (50-60% are
completely clean). Only around 20% of patches we mark as Changes
Requested are have issues <Low. Let's call that good enough.

The embargo on the reviews and time when review is emailed out follows
the same timeline as maintainer reviews. Delays are added if author
does not review other people's patches and if CI finds issues.
Paolo explained this a bit at netdev.conf.

Please let us know if you have any feedback, especially if you are 
a reviewer.
