Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31448641A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102241; cv=none; b=M6z3QZc7RdWk26TlCtTJturyT09zLYsZHqjaUxGVyRnBdBFiolmfmgs+rt13+2JeTyC42m2Q0h4y13++fsRwZyNE7vyluVeUaiy9rxgqWytAkMd9W7CZzLpWjNzRIxYndHmTrzD3MUkXWV5btIIVtEj8Husv06M/twQThNfUO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102241; c=relaxed/simple;
	bh=8kXOF0QdlhI9PrSwc2wXPbfYwkXiDdUcLCxqLBm+yBE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ijcRoSnIafZR7dHvPnZFytX6qpDLai2fWd26OVI8eTm0tOi1/oHrSnInUfBy0sYMh8J6kMb4fVifkNd/d4ia6AHdL30uqs44jN1aPK+Z9J4Q3tJlJAq8rNrA+Ei0/ZA9MBR0YtSfUeS1Qw0bATYLrCVOiZ+uwL4xcbqqkBI1FUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaLgY1YO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaLgY1YO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302D1F000FF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102240;
	bh=Q045fG5Je/JHcNYxW9iyyfQqv27yNAEPatvCPMPuyCk=;
	h=Date:From:To:Subject;
	b=FaLgY1YOt5eOzWf/Baa5YT6y0d0zJy/FABFNNcG5qMEKVg3d66MSmDrPTd/Fm85Ry
	 4DYf97bt0dYOw3orvW5BQlDZxkILbcDv+Sz6vv+7AqXkWyrfJlJgrPX9GqlLChBsfi
	 3MFnr7IRWa3Yxd3cX5+Gmq3ESAm0pgc4Wr+P2/LqeEmY7q7CZM9RMqsgEUPL81xYXT
	 CE3YMGaeYC6ZwDYB1F6v5+54KbFyE+O8Gy5RSFOG8ptwl5VK644odtmhfVGvr5wdly
	 kSiRZz329y1nN7ymPg6AZUzsOuJTybgeYFV4b6b7qQj7HoQJqvUcYipFcX0b3tv9+k
	 vluWLUKFfQ33g==
Date: Tue, 22 Sep 2026 11:37:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Sep 22nd
Message-ID: <20260922113719.07315d78@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Present: Andrew, Eric, Johannes, Iwashima-san, Jakub, Paolo, Willem, Simon

Next steps for logo
 - Work finished
 - Designer to submit the payment request and transfer design files

Request for funding for more NIC testing
 - Board approved the $55k USD budget
 - Needed last minute increase +$10k due to memory module shortage
   (16GB->32GB DIMM change), also approved
 - Waiting for PO to be issued by LF, hopefully quote will still be
   valid (expired on Mon)

Academic research program
 - Working on this with Brian Haberman (board chair)
 - Looking to announce in mid-October for 2027-2028 academic year

LPC / conferences
 - Paolo to attend, will assist in running Networking track

Membership renewal
 - TSC and Board happy to support members in this process
